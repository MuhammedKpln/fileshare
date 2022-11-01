import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';

import 'package:boilerplate/core/picker/file.picker.dart';
import 'package:boilerplate/features/file_transfer/helpers/transfer.helper.dart';
import 'package:boilerplate/features/find_user/models/event.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:peerdart/peerdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'file_transfer.controller.g.dart';

@LazySingleton(
  dispose: disposeFileTransferView,
)
class FileTransferViewController = _FileTransferViewControllerBase
    with _$FileTransferViewController;

abstract class _FileTransferViewControllerBase with Store {
  Peer? _peer;
  DataConnection? connection;
  final FilePickerWrappper _picker = FilePickerWrappper();

  String? _peerId;

  @observable
  String? connectedPeerUsername;

  @observable
  int gettedData = 0;

  FileInformation? get fileTransfering => receveidFilesQueue?.first;

  List<int> bytes = List.empty(growable: true);

  @observable
  ObservableList<FileInformation>? receveidFiles;

  Queue<FileInformation>? receveidFilesQueue;

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

  Queue<PlatformFile>? choosedFilesQueue;

  @observable
  ObservableList<PlatformFile>? choosedFilesRaw;

  StreamSubscription<dynamic>? _dataChannelStream;
  ReactionDisposer? autorunDisposer;
  ReactionDisposer? queueAutoRunDisposer;

  @action
  void startPeerListeners({
    required String peerId,
    required String connectedUserPeerId,
  }) {
    autorunDisposer = autorun((_) {
      /// Each time `choosedFiles` changes, it send over new file informations to the receiver

      choosedFiles?.length;
      sendFileInformations();
    });
    queueAutoRunDisposer = autorun((_) {
      /// Each time `choosedFilesRaw` or `receveidFiles` changes, it send over new file informations to the receiver

      if (choosedFilesRaw != null) {
        choosedFilesQueue = Queue.from(choosedFilesRaw!.toList());
      }

      if (receveidFiles != null) {
        receveidFilesQueue = Queue.from(receveidFiles!.toList());
      }

      print(choosedFilesQueue);
      print(receveidFilesQueue);
    });

    _peer = Peer(id: peerId, options: PeerOptions(debug: LogLevel.All));

    _peer?.on('open').listen((id) async {
      _peerId = id as String;
    });

    _peer?.on<DataConnection>('connection').listen((conn) {
      connection = conn;
    });

    _peer?.on('data').listen((data) async {
      final event = RtcEvent.fromMap(data as Map<String, dynamic>);

      switch (event.event) {
        case RTCEventType.fileInformations:
          final remoteFiles =
              event.data[RTCEventType.fileInformations.name] as List<dynamic>;

          if (remoteFiles.length > 0) {
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
          if (choosedFilesQueue != null && choosedFilesQueue!.isNotEmpty) {
            choosedFilesQueue?.removeFirst();

            if (choosedFilesQueue!.length > 0) {
              TransferHelper.startIsolate();
            }
          }
          break;
      }
    });

    _peer?.on<Uint8List>('binary').listen((_bytes) async {
      gettedData += _bytes.lengthInBytes;

      bytes.addAll(_bytes);

      print("${fileTransfering?.name} $gettedData - ${fileTransfering?.size}");
      if (fileTransfering != null) {
        if (fileTransfering?.size == gettedData) {
          /// Writing file to data
          await _writeData();

          /// Sending a notification to sender.
          final event = RtcEvent(
            event: RTCEventType.fileFetched,
            data: {"name": fileTransfering!.name, "fetched": true},
          ).toMap();
          await connection?.send(event);

          /// Resetting the data
          ///

          final changedlist = receveidFiles!.map((element) {
            if (element.name == fileTransfering!.name) {
              return element.copyWith(transfered: true);
            }

            return element;
          });

          receveidFiles = ObservableList.of(changedlist);

          gettedData = 0;
          receveidFilesQueue?.removeFirst();
          bytes.clear();
        }
      }
    });
  }

  Future<void> _writeData() async {
    final directory = await getApplicationDocumentsDirectory();
    final dirPath = directory.path;
    final fileWriter = File("$dirPath/${fileTransfering?.name}");

    await fileWriter.writeAsBytes(bytes, mode: FileMode.append);
  }

  void connectToPeer(String peerId) {
    connection = _peer?.connect(peerId);

    connection?.on('open').listen((event) {
      _dataChannelStream =
          connection?.dataChannel?.stateChangeStream.listen((event) async {
        if (event == RTCDataChannelState.RTCDataChannelOpen) {
          await sendUserProfile();
        }
      });
    });
  }

  void sendFiles() async {
    if (choosedFilesRaw == null) {
      return;
    }

    final port = ReceivePort();

    port.listen((message) async {
      await connection?.sendBinary(message as Uint8List);
    });

    // TransferHelper.sendFiles(port, choosedFilesRaw!);
  }

  Future<void> sendUserProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    await connection?.send(
      RtcEvent(
        event: RTCEventType.username,
        data: {'username': user?.userMetadata?['username']},
      ).toMap(),
    );
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

  void dispose() {
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
