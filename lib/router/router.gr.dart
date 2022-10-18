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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../features/core/components/scaffold_with_bottom_bar.dart' as _i1;
import '../features/posts/views/posts.view.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ScaffoldWithBottomBar.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.ScaffoldWithBottomBar(),
      );
    },
    PostsView.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.PostsView(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          ScaffoldWithBottomBar.name,
          path: '/',
          children: [
            _i3.RouteConfig(
              PostsView.name,
              path: 'posts-view',
              parent: ScaffoldWithBottomBar.name,
            )
          ],
        )
      ];
}

/// generated route for
/// [_i1.ScaffoldWithBottomBar]
class ScaffoldWithBottomBar extends _i3.PageRouteInfo<void> {
  const ScaffoldWithBottomBar({List<_i3.PageRouteInfo>? children})
      : super(
          ScaffoldWithBottomBar.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'ScaffoldWithBottomBar';
}

/// generated route for
/// [_i2.PostsView]
class PostsView extends _i3.PageRouteInfo<void> {
  const PostsView()
      : super(
          PostsView.name,
          path: 'posts-view',
        );

  static const String name = 'PostsView';
}
