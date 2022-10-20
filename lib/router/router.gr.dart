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
import 'package:boilerplate/features/auth/login/views/login.view.dart' as _i4;
import 'package:boilerplate/features/auth/main/views/main.view.dart' as _i1;
import 'package:boilerplate/features/home/views/home.view.dart' as _i3;
import 'package:boilerplate/features/send/views/send_file.view.dart'
    deferred as _i2;
import 'package:flutter/material.dart' as _i6;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainView(),
      );
    },
    SendFileRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i5.DeferredWidget(
          _i2.loadLibrary,
          () => _i2.SendFileView(),
        ),
        fullscreenDialog: true,
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginView(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              HomeRoute.name,
              path: 'home-view',
              parent: MainRoute.name,
            ),
            _i5.RouteConfig(
              LoginRoute.name,
              path: 'login-view',
              parent: MainRoute.name,
            ),
          ],
        ),
        _i5.RouteConfig(
          SendFileRoute.name,
          path: '/send-file-view',
          deferredLoading: true,
        ),
      ];
}

/// generated route for
/// [_i1.MainView]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.SendFileView]
class SendFileRoute extends _i5.PageRouteInfo<void> {
  const SendFileRoute()
      : super(
          SendFileRoute.name,
          path: '/send-file-view',
        );

  static const String name = 'SendFileRoute';
}

/// generated route for
/// [_i3.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoginView]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-view',
        );

  static const String name = 'LoginRoute';
}
