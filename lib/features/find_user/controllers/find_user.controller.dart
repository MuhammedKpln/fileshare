import 'dart:async';

import 'package:boilerplate/features/find_user/constants/uuid_regex.dart';
import 'package:boilerplate/features/find_user/models/event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:peerdart/peerdart.dart';
part 'find_user.controller.g.dart';

@LazySingleton(dispose: disposeFindUserView)
class FindUserViewController = _FindUserViewControllerBase
    with _$FindUserViewController;

abstract class _FindUserViewControllerBase with Store {
  Peer peer = Peer();
  DataConnection? connection;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @observable
  String? peerId;

  String? _peerId;

  String? get pId => _peerId;

  @observable
  bool connecting = false;

  Map<String, TextEditingController> formFields = {
    'findUserId': TextEditingController()
  };

  @computed
  String? get formFindUserId => formFields['findUserId']?.text;

  String? validateFormFindUserId(String? value) {
    if (value == null || value.isEmpty) {
      return 'findUserFormError'.tr();
    }

    return null;
  }

  @action
  void startListener({required void Function(String peerId) onNavigate}) {
    peer.on<String?>('open').listen((id) {
      _peerId = id;
    });

    peer.on<DataConnection>('connection').listen((conn) {
      connection = conn;
    });

    peer.on('error').listen((event) {
      connecting = false;
    });

    peer.on('data').listen(
      (event) {
        final rtcEvent = RtcEvent.fromJson(event as String);

        switch (rtcEvent.event) {
          case RTCEventType.navigatePing:
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
    connecting = true;
    connection = peer.connect(peerId);

    connection?.on('open').listen((event) {
      connection?.dataChannel?.stateChangeStream.listen((event) {
        if (event == RTCDataChannelState.RTCDataChannelOpen) {
          pingUserToNavigate();

          peer.disconnect();

          Future.delayed(const Duration(seconds: 3), () {
            connecting = false;
            onConnectionSuccess();
          });
        }
      });
    });
  }

  Future<void> pingUserToNavigate() async {
    await connection?.send(
      RtcEvent(
        event: RTCEventType.navigatePing,
        data: {'navigate': true, 'peerId': _peerId},
      ).toJson(),
    );
  }

  void dispose() {
    peer.dispose();
  }

  Future<void> askForConnectingFromClipboard(
    void Function(String clipboardData) onSuccess,
  ) async {
    final hasClipboardData = await _hasClipboardData();

    if (hasClipboardData) {
      final clipboardData = await Clipboard.getData('text/plain');

      if (_isRegex(clipboardData!.text!)) {
        onSuccess.call(clipboardData.text!);
      }
    }
  }

  bool _isRegex(String data) {
    if (uuidRegex.hasMatch(data)) {
      return true;
    }

    return false;
  }

  Future<bool> _hasClipboardData() async {
    return Clipboard.hasStrings();
  }
}

FutureOr disposeFindUserView(FindUserViewController instance) {
  instance.dispose();
}
