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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:boilerplate/features/auth/main/views/main.view.dart' as _i1;
import 'package:boilerplate/features/auth/views/login/login.view.dart'
    deferred as _i2;
import 'package:boilerplate/features/auth/views/register/register.view.dart'
    deferred as _i3;
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart'
    deferred as _i4;
import 'package:boilerplate/features/find_user/views/find_user.view.dart'
    deferred as _i5;
import 'package:boilerplate/features/find_user/views/scan_qr_code.dart'
    deferred as _i6;
import 'package:boilerplate/features/home/views/home.view.dart' as _i7;
import 'package:boilerplate/router/guards/auth.guard.dart' as _i10;
import 'package:flutter/material.dart' as _i9;

class AppRouter extends _i8.RootStackRouter {
  AppRouter({
    _i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i10.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.LoginView(),
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.RegisterView(),
        ),
      );
    },
    FileTransferRoute.name: (routeData) {
      final args = routeData.argsAs<FileTransferRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.FileTransferView(
            key: args.key,
            sendingFile: args.sendingFile,
            connectedPeer: args.connectedPeer,
            currentPeer: args.currentPeer,
          ),
        ),
      );
    },
    FindUserRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i5.loadLibrary,
          () => _i5.FindUserView(),
        ),
        fullscreenDialog: true,
      );
    },
    ScanQRCodeRoute.name: (routeData) {
      final args = routeData.argsAs<ScanQRCodeRouteArgs>();
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.DeferredWidget(
          _i6.loadLibrary,
          () => _i6.ScanQRCodeView(
            key: args.key,
            onCodeScanned: args.onCodeScanned,
          ),
        ),
        fullscreenDialog: true,
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeView(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          MainRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i8.RouteConfig(
              HomeRoute.name,
              path: 'home-view',
              parent: MainRoute.name,
            )
          ],
        ),
        _i8.RouteConfig(
          LoginRoute.name,
          path: '/login-view',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          RegisterRoute.name,
          path: '/register-view',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          FileTransferRoute.name,
          path: '/file-transfer-view',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          FindUserRoute.name,
          path: '/find-user-view',
          deferredLoading: true,
        ),
        _i8.RouteConfig(
          ScanQRCodeRoute.name,
          path: '/scan-qr-code-view',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.MainView]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterView]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-view',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.FileTransferView]
class FileTransferRoute extends _i8.PageRouteInfo<FileTransferRouteArgs> {
  FileTransferRoute({
    _i9.Key? key,
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

  final _i9.Key? key;

  final bool sendingFile;

  final String connectedPeer;

  final String currentPeer;

  @override
  String toString() {
    return 'FileTransferRouteArgs{key: $key, sendingFile: $sendingFile, connectedPeer: $connectedPeer, currentPeer: $currentPeer}';
  }
}

/// generated route for
/// [_i5.FindUserView]
class FindUserRoute extends _i8.PageRouteInfo<void> {
  const FindUserRoute()
      : super(
          FindUserRoute.name,
          path: '/find-user-view',
        );

  static const String name = 'FindUserRoute';
}

/// generated route for
/// [_i6.ScanQRCodeView]
class ScanQRCodeRoute extends _i8.PageRouteInfo<ScanQRCodeRouteArgs> {
  ScanQRCodeRoute({
    _i9.Key? key,
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

  final _i9.Key? key;

  final void Function(String?) onCodeScanned;

  @override
  String toString() {
    return 'ScanQRCodeRouteArgs{key: $key, onCodeScanned: $onCodeScanned}';
  }
}

/// generated route for
/// [_i7.HomeView]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeRoute';
}
