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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:boilerplate/features/auth/main/views/main.view.dart' as _i1;
import 'package:boilerplate/features/auth/views/login/login.view.dart'
    deferred as _i2;
import 'package:boilerplate/features/auth/views/register/register.view.dart'
    deferred as _i3;
import 'package:boilerplate/features/file_transfer/views/file_transfer.view.dart'
    deferred as _i4;
import 'package:boilerplate/features/home/views/home.view.dart' as _i5;
import 'package:boilerplate/router/guards/auth.guard.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

class AppRouter extends _i6.RootStackRouter {
  AppRouter({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.LoginView(),
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i3.loadLibrary,
          () => _i3.RegisterView(),
        ),
      );
    },
    FileTransferRoute.name: (routeData) {
      final args = routeData.argsAs<FileTransferRouteArgs>();
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.DeferredWidget(
          _i4.loadLibrary,
          () => _i4.FileTransferView(
            key: args.key,
            sendingFile: args.sendingFile,
          ),
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          MainRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i6.RouteConfig(
              HomeRoute.name,
              path: 'home-view',
              parent: MainRoute.name,
            )
          ],
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login-view',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          RegisterRoute.name,
          path: '/register-view',
          deferredLoading: true,
        ),
        _i6.RouteConfig(
          FileTransferRoute.name,
          path: '/file-transfer-view',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.MainView]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.RegisterView]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-view',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i4.FileTransferView]
class FileTransferRoute extends _i6.PageRouteInfo<FileTransferRouteArgs> {
  FileTransferRoute({
    _i7.Key? key,
    required bool sendingFile,
  }) : super(
          FileTransferRoute.name,
          path: '/file-transfer-view',
          args: FileTransferRouteArgs(
            key: key,
            sendingFile: sendingFile,
          ),
        );

  static const String name = 'FileTransferRoute';
}

class FileTransferRouteArgs {
  const FileTransferRouteArgs({
    this.key,
    required this.sendingFile,
  });

  final _i7.Key? key;

  final bool sendingFile;

  @override
  String toString() {
    return 'FileTransferRouteArgs{key: $key, sendingFile: $sendingFile}';
  }
}

/// generated route for
/// [_i5.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeRoute';
}
