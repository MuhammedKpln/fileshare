import 'dart:async';

import 'package:boilerplate/core/picker/file.picker.dart';
import 'package:boilerplate/features/find_user/models/event.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:peerdart/peerdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @observable
  ObservableList<FileInformation>? receveidFiles;

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

  @observable
  ObservableList<PlatformFile>? choosedFilesRaw;

  StreamSubscription? _dataChannelStream;
  ReactionDisposer? autorunDisposer;

  @action
  void startPeerListeners({
    required String peerId,
    required String connectedUserPeerId,
  }) {
    autorunDisposer = autorun((_) {
      if (choosedFiles != null) {
        sendFileInformations();
      }
    });

    _peer = Peer(
      id: peerId,
      options: PeerOptions(
        host: '4754-78-82-142-36.eu.ngrok.io',
        debug: LogLevel.All,
      ),
    );

    _peer?.on('open').listen((id) async {
      _peerId = id as String;
    });

    _peer?.on<DataConnection>('connection').listen((conn) {
      connection = conn;
    });

    _peer?.on('data').listen((data) async {
      final event = RtcEvent.fromJson(data as Map<String, dynamic>);

      switch (event.event) {
        case RTCEventType.fileInformation:
          final remoteFiles = event.data['fileInformations'] as List<dynamic>;
          final mappedData = remoteFiles
              .map((e) => FileInformation.fromJson(e as Map<String, dynamic>))
              .toList();

          receveidFiles = ObservableList.of(mappedData);
          break;

        case RTCEventType.data:
          connectedPeerUsername = event.data['username'] as String;

          break;
      }
    });

    _peer?.on<Uint8List>('binary').listen((event) async {
      gettedData += event.lengthInBytes;
    });
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

  void sendFiles() {
    if (choosedFilesRaw == null) {
      return;
    }

    for (final file in choosedFilesRaw!) {
      file.readStream?.listen((bytes) async {
        await connection?.sendBinary(Uint8List.fromList(bytes));
      });
    }
  }

  Future<void> sendUserProfile() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    await connection?.send(
      RtcEvent(
        event: RTCEventType.data,
        data: {'username': user?.userMetadata?['username']},
      ).toJson(),
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

  Future<void> sendFileInformations() async {
    await connection?.send(
      RtcEvent(
        event: RTCEventType.fileInformation,
        data: {'fileInformations': choosedFiles},
      ).toJson(),
    );
  }

  void dispose() {
    autorunDisposer?.call();
    _dataChannelStream?.cancel();
    _peer?.dispose();
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
