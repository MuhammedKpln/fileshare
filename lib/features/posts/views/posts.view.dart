// ignore_for_file: lines_longer_than_80_chars

import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/async_value.extension.dart';
import 'package:boilerplate/features/auth/controllers/auth.controller.dart';
import 'package:boilerplate/features/posts/controllers/posts_view.controller.dart';
import 'package:boilerplate/features/posts/models/base_posts.model.dart';
import 'package:boilerplate/features/posts/views/components/posts/posts.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

/// `PostsView` is a `StatelessWidget` that displays a
/// `Scaffold` with an `AppBar` and a `Posts` widget that displays a list of `Post`
class PostsView extends StatelessWidget {
  /// A constructor that is calling the super class constructor.
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = getIt<PostsViewController>();
    final authController = getIt<AuthViewController>();

    Future<void> logout() async {
      await authController.logout();
    }

    void navigateToSettings() {
      context.pushNamed(RouteMetaData.settings.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('postsViewTitle').tr(),
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: navigateToSettings,
        ),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Observer(
        builder: (context) {
          return controller.posts!.asyncValue<BasePosts>(
            pending: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            fulfilled: (data) => Posts(posts: data),
            rejected: (err) => Text('error $err'),
          );
        },
      ),
    );
  }
}
