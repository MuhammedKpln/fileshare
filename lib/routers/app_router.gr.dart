// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../features/file_transfer/views/file_transfer.view.dart' as _i2;
import '../features/find_user/views/find_user.view.dart' as _i3;
import '../features/find_user/views/scan_qr_code.dart' as _i4;
import '../features/home/views/home.view.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    FileTransferRoute.name: (routeData) {
      final args = routeData.argsAs<FileTransferRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.FileTransferView(
          key: args.key,
          sendingFile: args.sendingFile,
          connectedPeer: args.connectedPeer,
          currentPeer: args.currentPeer,
        ),
      );
    },
    FindUserRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.FindUserView(),
        fullscreenDialog: true,
      );
    },
    ScanQRCodeRoute.name: (routeData) {
      final args = routeData.argsAs<ScanQRCodeRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ScanQRCodeView(
          key: args.key,
          onCodeScanned: args.onCodeScanned,
        ),
        fullscreenDialog: true,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          FileTransferRoute.name,
          path: '/file-transfer-view',
        ),
        _i5.RouteConfig(
          FindUserRoute.name,
          path: '/find-user-view',
        ),
        _i5.RouteConfig(
          ScanQRCodeRoute.name,
          path: '/scan-qr-code-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.FileTransferView]
class FileTransferRoute extends _i5.PageRouteInfo<FileTransferRouteArgs> {
  FileTransferRoute({
    _i6.Key? key,
    required bool sendingFile,
    required String connectedPeer,
    required String currentPeer,
  }) : super(
          FileTransferRoute.name,
          path: '/file-transfer-view',
          args: FileTransferRouteArgs(
            key: key,
            sendingFile: sendingFile,
            connectedPeer: connectedPeer,
            currentPeer: currentPeer,
          ),
        );

  static const String name = 'FileTransferRoute';
}

class FileTransferRouteArgs {
  const FileTransferRouteArgs({
    this.key,
    required this.sendingFile,
    required this.connectedPeer,
    required this.currentPeer,
  });

  final _i6.Key? key;

  final bool sendingFile;

  final String connectedPeer;

  final String currentPeer;

  @override
  String toString() {
    return 'FileTransferRouteArgs{key: $key, sendingFile: $sendingFile, connectedPeer: $connectedPeer, currentPeer: $currentPeer}';
  }
}

/// generated route for
/// [_i3.FindUserView]
class FindUserRoute extends _i5.PageRouteInfo<void> {
  const FindUserRoute()
      : super(
          FindUserRoute.name,
          path: '/find-user-view',
        );

  static const String name = 'FindUserRoute';
}

/// generated route for
/// [_i4.ScanQRCodeView]
class ScanQRCodeRoute extends _i5.PageRouteInfo<ScanQRCodeRouteArgs> {
  ScanQRCodeRoute({
    _i6.Key? key,
    required void Function(String?) onCodeScanned,
  }) : super(
          ScanQRCodeRoute.name,
          path: '/scan-qr-code-view',
          args: ScanQRCodeRouteArgs(
            key: key,
            onCodeScanned: onCodeScanned,
          ),
        );

  static const String name = 'ScanQRCodeRoute';
}

class ScanQRCodeRouteArgs {
  const ScanQRCodeRouteArgs({
    this.key,
    required this.onCodeScanned,
  });

  final _i6.Key? key;

  final void Function(String?) onCodeScanned;

  @override
  String toString() {
    return 'ScanQRCodeRouteArgs{key: $key, onCodeScanned: $onCodeScanned}';
  }
}
