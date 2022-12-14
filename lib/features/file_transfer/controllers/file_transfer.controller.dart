import 'dart:async';
import 'dart:collection';

import 'dart:io';

import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/picker/file.picker.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/file_transfer/helpers/transfer.helper.dart';
import 'package:boilerplate/features/find_user/models/event.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:boilerplate/features/settings/storage/settings.storage.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peerdart/peerdart.dart';
import 'package:unique_name_generator/unique_name_generator.dart';

part 'file_transfer.controller.g.dart';

@LazySingleton(
  dispose: disposeFileTransferView,
)
class FileTransferViewController = _FileTransferViewControllerBase
    with _$FileTransferViewController;

abstract class _FileTransferViewControllerBase with Store {
  _FileTransferViewControllerBase(
    this._toast,
    this._picker,
    this._settingsStorage,
  );
  final Toast _toast;

  Peer? _peer;
  DataConnection? connection;
  final FilePickerWrappper _picker;
  final SettingsStorage _settingsStorage;

  String? _peerId;

  @observable
  String? connectedPeerUsername;

  @observable
  int gettedData = 0;

  @observable
  bool disconnected = false;

  @observable
  String localUsername = '';

  @computed
  FileInformation? get fileTransfering => receveidFilesQueue?.first;

  @observable
  BytesBuilder bytes = BytesBuilder();

  @computed
  int get len => bytes.length;

  @observable
  ObservableList<FileInformation>? receveidFiles;

  @observable
  Queue<FileInformation>? receveidFilesQueue;

  /// A boolean variable that is used to check if the file transfer is in progress.
  @observable
  bool isTransfering = false;

  @computed
  List<FileInformation>? get choosedFiles {
    final mappedData = choosedFilesRaw
        ?.map(
          (e) => FileInformation(
            name: e.name,
            size: e.size,
            extension: e.extension,
          ),
        )
        .toList();

    return mappedData;
  }

  ObservableList<FileInformation?> transferedFiles = ObservableList.of([]);

  Queue<PlatformFile>? choosedFilesQueue;

  @observable
  ObservableList<PlatformFile>? choosedFilesRaw;

  @computed
  double get progressPercent =>
      ((gettedData / fileTransfering!.size) * 100) / 100;

  StreamSubscription<dynamic>? _dataChannelStream;
  ReactionDisposer? autorunDisposer;
  ReactionDisposer? queueAutoRunDisposer;

  @action
  void startPeerListeners({
    required String peerId,
    required String connectedUserPeerId,
    required VoidCallback onUserDisconnect,
  }) {
    autorunDisposer = autorun((_) {
      /// Each time `choosedFiles` changes, it send over new file informations to the receiver

      choosedFiles?.length;
      sendFileInformations();
    });
    queueAutoRunDisposer = autorun((_) {
      /// Each time `choosedFilesRaw` or `receveidFiles` changes,
      /// it send over new file informations to the receiver

      if (choosedFilesRaw != null) {
        choosedFilesQueue = Queue.from(choosedFilesRaw!.toList());
      }

      if (receveidFiles != null) {
        receveidFilesQueue = Queue.from(receveidFiles!.toList());
      }
    });
    localUsername = _generateRandomName();
    _peer = Peer(id: peerId);

    _peer?.on('open').listen((id) async {
      _peerId = id as String;
    });

    _peer?.on<DataConnection>('connection').listen((conn) {
      connection = conn;

      conn.once('open').then((value) async {
        await sendUserProfile();
      });

      _eventHandler(onUserDisconnect: onUserDisconnect);
    });
  }

  Future<void> _writeData() async {
    final savedDirectory = await _settingsStorage.getDownloadDir();
    File? fileWriter;

    if (savedDirectory != null) {
      fileWriter = File('$savedDirectory/${fileTransfering?.name}');
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final dirPath = directory.path;
      fileWriter = File('$dirPath/${fileTransfering?.name}');
    }

    await fileWriter.writeAsBytes(bytes.toBytes(), mode: FileMode.append);
  }

  void connectToPeer(
    String peerId, {
    required VoidCallback onUserDisconnect,
  }) {
    connection = _peer?.connect(peerId);

    connection?.on('open').listen((event) async {
      await sendUserProfile();

      _eventHandler(onUserDisconnect: onUserDisconnect);
    });
  }

  Future<void> sendUserProfile() async {
    await connection?.send(
      RtcEvent(
        event: RTCEventType.username,
        data: {'username': localUsername},
      ).toMap(),
    );
  }

  String _generateRandomName() {
    final generator = UniqueNameGenerator(
      dictionaries: [names],
      separator: ' ',
      style: NameStyle.capital,
    );
    return generator.generate();
  }

  @action
  Future<List<PlatformFile>?> pickFile() async {
    final files = await _picker.pickFile();

    if (files != null) {
      choosedFilesRaw = ObservableList.of(files);
    }
    return null;
  }

  @action
  void clearFiles() {
    choosedFilesRaw = null;
  }

  @action
  void removeFile(FileInformation file) {
    choosedFilesRaw?.removeWhere((element) => element.name == file.name);
  }

  Future<void> sendFileInformations({RtcEvent? event}) async {
    await connection?.send(
      event?.toMap() ??
          RtcEvent(
            event: RTCEventType.fileInformations,
            data: {RTCEventType.fileInformations.name: choosedFiles ?? []},
          ).toMap(),
    );
  }

  void _eventHandler({
    required VoidCallback onUserDisconnect,
  }) {
    connection?.on('data').listen((data) async {
      final event = RtcEvent.fromMap(data as Map<String, dynamic>);

      switch (event.event) {
        case RTCEventType.fileInformations:
          final remoteFiles =
              event.data[RTCEventType.fileInformations.name] as List<dynamic>;

          if (remoteFiles.isNotEmpty) {
            final mappedData = remoteFiles
                .map((e) => FileInformation.fromJson(e as String))
                .toList();
            receveidFiles = ObservableList.of(mappedData);
          } else {
            receveidFiles = null;
          }

          break;

        case RTCEventType.username:
          connectedPeerUsername = event.data['username'] as String;
          break;

        case RTCEventType.fileFetched:
          final name = event.data['name'] as String;
          final fetched = event.data['fetched'] as bool;
          final file =
              choosedFiles?.where((element) => element.name == name).single;
          final size = file?.size ?? 0;
          final extension = file?.extension;

          if (choosedFilesQueue != null && choosedFilesQueue!.isNotEmpty) {
            choosedFilesQueue?.removeFirst();

            if (choosedFilesQueue!.isNotEmpty) {
              await TransferHelper.startIsolate();
            } else {
              // Transfering queue is empty that means the transfer is done.
              isTransfering = false;
              choosedFilesRaw?.removeWhere((element) => element.name == name);

              transferedFiles.add(
                FileInformation(
                  name: name,
                  size: size,
                  transfered: true,
                  extension: extension,
                ),
              );

              _toast.showToast(LocaleKeys.transferingIsDone.tr());
            }
          }
          break;

        case RTCEventType.leavePing:
          disconnected = true;
          _toast.showToast(
            LocaleKeys.userDisconnectedMessage.tr(),
            toastType: ToastType.error,
            action: SnackBarAction(
              label: LocaleKeys.closeConnectionBtnTxt.tr(),
              onPressed: onUserDisconnect,
            ),
          );
          break;
      }
    });

    connection?.on<Uint8List>('binary').listen((receveidBytes) async {
      if (!isTransfering) {
        isTransfering = true;
      }

      bytes.add(receveidBytes);
      gettedData += receveidBytes.lengthInBytes;

      if (fileTransfering != null) {
        if (fileTransfering?.size == bytes.length) {
          /// Writing file to data
          await _writeData();

          transferedFiles.add(fileTransfering);
          isTransfering = false;

          /// Sending a notification to sender.
          final event = RtcEvent(
            event: RTCEventType.fileFetched,
            data: {'name': fileTransfering!.name, 'fetched': true},
          ).toMap();
          await connection?.send(event);

          /// Resetting the data
          ///

          receveidFilesQueue?.removeFirst();
          bytes.clear();
          gettedData = 0;

          if (receveidFilesQueue!.isEmpty) {
            _toast.showToast(LocaleKeys.transferingIsDone.tr());
          }
        }
      }
    });
  }

  void pingPeerForLeaving() {
    connection
        ?.send(const RtcEvent(event: RTCEventType.leavePing, data: {}).toMap());
  }

  void dispose() {
    if (!disconnected) {
      pingPeerForLeaving();
    }

    autorunDisposer?.call();
    queueAutoRunDisposer?.call();
    _dataChannelStream?.cancel();
    _peer?.dispose();
    bytes.clear();
  }
}

/// Dispose of the file transfer view controller.
///
/// Args:
///   instance (FileTransferViewController): The instance of the view controller
///  that you want to
/// dispose.
FutureOr disposeFileTransferView(FileTransferViewController instance) {
  instance.dispose();
}
