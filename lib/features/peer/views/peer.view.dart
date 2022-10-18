import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/peer/controllers/peer.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PeerView extends StatefulWidget {
  const PeerView({super.key});

  @override
  State<PeerView> createState() => _PeerViewState();
}

class _PeerViewState extends State<PeerView> {
  final viewController = getIt<PeerViewController>();

  @override
  void initState() {
    super.initState();

    viewController.startPeer();
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<PeerViewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Observer(
            builder: (_) {
              return SelectableText(viewController.peerId ?? '');
            },
          ),
          TextField(
            controller: viewController.idController,
          ),
          ElevatedButton(
            onPressed: viewController.connect,
            child: const Text('call'),
          ),
          ElevatedButton(
            onPressed: viewController.sendHelloWorld,
            child: const Text('hello'),
          ),
          ElevatedButton(
            onPressed: viewController.sendFile,
            child: const Text('send binary'),
          ),
          Observer(
            builder: (_) {
              return CircularProgressIndicator(
                value: viewController.progressBar,
                color: Colors.green,
              );
            },
          ),
        ],
      ),
    );
  }
}
