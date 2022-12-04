import 'dart:isolate';
import 'dart:math';

import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/file_transfer/controllers/file_transfer.controller.dart';
import 'package:boilerplate/features/find_user/models/file_information.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum TransferIsolateMessage { chunk, doneFile, fileBegin }

class IsolateMessageHandler {
  const IsolateMessageHandler({required this.type, this.data});

  final TransferIsolateMessage type;
  final dynamic data;
}

class TransferHelper {
  static const int defaultMaxSize = 16 * 1000;
  static final RegExp _findRegex = RegExp('(a=max-message-size:)+([1-9]*)');

  static int findTransferSize(String input) {
    final found = _findRegex.hasMatch(input);

    if (found) {
      final allMatches = _findRegex.allMatches(input);
      final groupCount = allMatches.first.groupCount;

      if (groupCount == 2) {
        return int.tryParse(allMatches.first.group(2)!)!;
      }
    }

    return defaultMaxSize;
  }

  static Stream<Uint8List> chunk(
    List<int> list, {
    int chunkSize = 16000,
  }) async* {
    var chunk = <int>[];

    while (list.isNotEmpty) {
      if (list.length > chunkSize) {
        chunk = list.sublist(0, chunkSize);
        list = list.sublist(chunkSize, list.length);
      } else {
        chunk = list.sublist(0);
        list = list.sublist(list.length);
      }

      yield Uint8List.fromList(chunk);
    }
  }

  static void isolate(List<dynamic> args) {
    final port = args[0] as SendPort;
    final file = args[1] as PlatformFile;
    final chunkSize = args[2] as int;

    final fileBytes = <Uint8List>[];

    file.readStream?.forEach((element) {
      chunk(element, chunkSize: chunkSize).listen((chunk) {
        fileBytes.add(chunk);
      });
    }).whenComplete(() async {
      /// Send file information, receiver knows which file is being transferred.

      for (final byte in fileBytes) {
        await Future.delayed(const Duration(milliseconds: 10), () async {
          if (fileBytes.first.hashCode == byte.hashCode) {
            /// Sending first byte.
            port.send(
              IsolateMessageHandler(
                type: TransferIsolateMessage.fileBegin,
                data: FileInformation(
                  name: file.name,
                  size: file.size,
                  extension: file.extension,
                ),
              ),
            );
          }

          if (fileBytes.last.hashCode == byte.hashCode) {
            /// When loop is done, file has been sended over.

            print('${file.size} ${fileBytes.length}');
            port.send(
              IsolateMessageHandler(
                type: TransferIsolateMessage.doneFile,
                data: FileInformation(
                  name: file.name,
                  extension: file.extension,
                  size: file.size,
                ),
              ),
            );
          }

          port.send(
            IsolateMessageHandler(
              type: TransferIsolateMessage.chunk,
              data: byte,
            ),
          );
        });
      }
    });
  }

  /// It converts bytes to KB, MB, GB, TB, PB, EB, ZB, YB.
  ///
  /// Args:
  ///   bytes (num): The number of bytes to format.
  ///   decimals (int): The number of decimals to show. Defaults to 2
  ///
  /// Returns:
  ///   A string with the number of bytes and the appropriate unit.
  static String formatBytes(num bytes, {int decimals = 2}) {
    const k = 1000;
    final dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    final i = (log(bytes) / log(k)).floor();

    return (bytes / pow(k, i)).toStringAsFixed(dm) + sizes[i];
  }

  static Future<void> startIsolate() async {
    final appController = getIt<FileTransferViewController>();
    final receivePort = ReceivePort();

    receivePort.listen((message) async {
      if (message == null) {
        return;
      }

      if (message is String) {
        if (message == 'DONE') {
          appController.choosedFilesQueue?.removeFirst();
          receivePort.close();
        }

        return;
      }

      final handler = message as IsolateMessageHandler;

      switch (handler.type) {
        case TransferIsolateMessage.chunk:
          final data = handler.data as Uint8List;
          await appController.connection?.sendBinary(data);
          break;
        case TransferIsolateMessage.doneFile:
          final data = handler.data as FileInformation;
          final fileName = data.name;

          print('Sending done $fileName');
          break;
        case TransferIsolateMessage.fileBegin:
          final data = handler.data as FileInformation;
          final fileName = data.name;

          print('Sending file $fileName');
          break;
      }
    });

    var localMaxSize = TransferHelper.defaultMaxSize;
    var remoteMaxSize = TransferHelper.defaultMaxSize;

    final remoteDescription =
        await appController.connection?.peerConnection?.getRemoteDescription();

    final localDescription =
        await appController.connection?.peerConnection?.getLocalDescription();

    if (remoteDescription != null) {
      remoteMaxSize = TransferHelper.findTransferSize(remoteDescription.sdp!);
    }

    if (localDescription != null) {
      localMaxSize = TransferHelper.findTransferSize(localDescription.sdp!);
    }

    final chunkSize = min(localMaxSize, remoteMaxSize);

    final isolate = await Isolate.spawn(
      TransferHelper.isolate,
      [receivePort.sendPort, appController.choosedFilesQueue!.first, chunkSize],
      onExit: receivePort.sendPort,
      onError: receivePort.sendPort,
    );

    isolate.addOnExitListener(
      receivePort.sendPort,
    );
  }
}
