import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart' as s;
import 'package:peerdart/peerdart.dart';

part 'peer.controller.g.dart';

@LazySingleton(dispose: disposePeer)
class PeerViewController = _PeerViewControllerBase with _$PeerViewController;

abstract class _PeerViewControllerBase with Store {
  late final Peer peer;

  final idController = TextEditingController();

  String get id => idController.text;

  @observable
  String? peerId;

  @observable
  int receivedSize = 0;

  final int maxSize = 109983184;

  @computed
  double get progressBar => receivedSize / maxSize;

  DataConnection? connection;

  @observable
  Uint8List? pickedFile;

  @disposeMethod
  void dispose() {
    pickedFile = Uint8List(0);
    peer.dispose();
  }

  Future<String> getFilePath() async {
    final appDocumentsDirectory = await s.getTemporaryDirectory(); // 1
    final appDocumentsPath = appDocumentsDirectory.path; // 2
    final filePath = '$appDocumentsPath/image.image'; // 3

    return filePath;
  }

  void startPeer() {
    peer = Peer();

    peer.once<String?>('open').then((value) {
      peerId = value;
    });

    peer.on<DataConnection>('connection').listen((conn) {
      connection = conn;
    });

    peer.on<Uint8List>('file').listen(
      (bytes) async {
        receivedSize += bytes.lengthInBytes;

        await File(await getFilePath()).writeAsBytes(bytes);
      },
    );

    peer.on<dynamic>('data').listen(print);
  }

  void sendHelloWorld() {
    connection?.send('Hello world');
  }

  Future<Stream<List<int>>?> pickFile() async {
    final file = await FilePicker.platform.pickFiles(withReadStream: true);

    if (file != null) {
      return file.files.single.readStream;
    }
    return null;
  }

  Future<void> sendFile() async {
    final file = await pickFile();

    if (file != null) {
      file.listen((event) {
        connection?.sendBinary(Uint8List.fromList(event));
      });
    }
  }

  void connect() {
    connection = peer.connect(id);

    connection?.on('data').listen((event) {
      peer.on<DataConnection>('connection').listen((conn) {
        connection = conn;
      });
    });
  }
}

/// dispose function signature must match Function(T instance)
void disposePeer(PeerViewController instance) {
  instance.dispose();
}
