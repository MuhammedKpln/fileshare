import 'package:boilerplate/features/posts/models/base_posts.model.dart';
import 'package:boilerplate/router/paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// `Posts` is a `StatelessWidget` that displays a list of `Post`s
class Posts extends StatelessWidget {
  /// A constructor that takes a `key` and a `posts` parameter.
  const Posts({super.key, required this.posts});

  /// Posts
  final BasePosts posts;

  @override
  Widget build(BuildContext context) {
    /// `context.goNamed` is a function that takes a route name and a map of
    /// parameters and navigates to the route
    ///
    /// Args:
    ///   postId (int): The id of the post to navigate to.
    void navigateToPost(int postId) {
      context.pushNamed(
        RouteMetaData.post.routeName,
        params: {'id': postId.toString()},
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final post = posts.posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body.substring(0, 100)),
          onTap: () => navigateToPost(post.id),
        );
      },
      itemCount: posts.limit,
    );
  }
}
