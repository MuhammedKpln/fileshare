import 'dart:async';

import 'package:boilerplate/features/find_user/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:peerdart/peerdart.dart';
part 'find_user.controller.g.dart';

@LazySingleton(dispose: disposeFindUserView)
class FindUserViewController = _FindUserViewControllerBase
    with _$FindUserViewController;

abstract class _FindUserViewControllerBase with Store {
  Peer peer = Peer(
    options: PeerOptions(
      host: '4754-78-82-142-36.eu.ngrok.io',
    ),
  );
  DataConnection? connection;

  @observable
  String? peerId;

  String? _peerId;

  String? get pId => _peerId;

  @observable
  bool connecting = false;

  // @action
  // Future<List<PlatformFile>?> pickFile() async {
  //   final files = await _picker.pickFile();

  //   if (files != null) {
  //     choosedFilesRaw = files;

  //     for (final file in files) {
  //       choosedFiles.add(
  //         FileInformation(
  //           name: file.name,
  //           size: file.size,
  //           extension: file.extension,
  //         ),
  //       );
  //     }
  //   }

  //   return files;
  // }
  @action
  void startListener({required void Function(String peerId) onNavigate}) {
    peer.on<String?>('open').listen((id) {
      _peerId = id;
    });

    peer.on<DataConnection>('connection').listen((conn) {
      connection = conn;
    });

    peer.on('data').listen(
      (event) {
        final rtcEvent = RTCEvent.fromJson(event as Map<String, dynamic>);

        switch (rtcEvent.event) {
          case RTCEventType.data:
            if (rtcEvent.data['navigate'] != null &&
                rtcEvent.data['navigate'] == true) {
              connecting = true;
              try {
                peer.disconnect();
              } catch (e) {}

              Future.delayed(const Duration(seconds: 3), () {
                connecting = false;
                onNavigate.call(rtcEvent.data['peerId'] as String);
              });
            }

            break;
          case RTCEventType.fileInformation:
            // TODO: Handle this case.
            break;
        }
      },
    );
  }

  @action
  void generateId() {
    peerId = _peerId;
  }

  @action
  void connectToPeer(String peerId, VoidCallback onConnectionSuccess) {
    connection = peer.connect(peerId);

    connection?.on('open').listen((event) {
      connection?.dataChannel?.stateChangeStream.listen((event) {
        if (event == RTCDataChannelState.RTCDataChannelOpen) {
          pingUserToNavigate();

          peer.disconnect();
          connecting = true;

          Future.delayed(const Duration(seconds: 3), () {
            connecting = false;
            onConnectionSuccess();
          });
        }
      });
    });
  }

  // Future<void> sendFileInformation(List<PlatformFile> files) async {
  //   final fileInformations = <FileInformation>[];

  //   for (final file in files) {
  //     fileInformations.add(
  //       FileInformation(
  //         name: file.name,
  //         size: file.size,
  //         extension: file.extension,
  //       ),
  //     );
  //   }

  //   await connection?.send(
  //     RTCEvent(
  //       event: RTCEventType.fileInformation,
  //       data: fileInformations,
  //     ).toJson(),
  //   );
  // }

  Future<void> pingUserToNavigate() async {
    await connection?.send(
      RTCEvent(
        event: RTCEventType.data,
        data: {'navigate': true, 'peerId': _peerId},
      ).toJson(),
    );
  }

  void dispose() {
    peer.dispose();
  }
}

FutureOr disposeFindUserView(FindUserViewController instance) {
  instance.dispose();
}
