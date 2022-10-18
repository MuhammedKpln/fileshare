// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/features/core/components/scaffold_with_bottom_bar.dart';
import 'package:boilerplate/features/posts/views/posts.view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: ScaffoldWithBottomBar,
      initial: true,
      children: [AutoRoute(page: PostsView)],
    ),
  ],
)
class $AppRouter {}
