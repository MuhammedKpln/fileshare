import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/extensions/async_value.extension.dart';
import 'package:boilerplate/features/posts/controllers/post_details_view.controller.dart';
import 'package:boilerplate/features/posts/models/post.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// It returns an Observer widget that renders a Text widget with the
///  title of the post

class PostDetailsView extends StatelessWidget {
  ///
  const PostDetailsView({super.key, required this.postId});

  /// A required parameter that will be passed to the widget.
  final int postId;

  /// Returns:
  ///   A widget that displays a circular progress indicator.
  Widget renderLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  /// If the error is a Dart error, render it as a Text widget
  ///
  /// Args:
  ///   error (dynamic): The error that was thrown.
  ///
  /// Returns:
  ///   A widget that displays the error message.
  Widget renderError(dynamic error) {
    return Center(child: Text(error.toString()));
  }

  /// `renderData` is a function that takes a `Post` object and returns a
  /// `Widget` that displays the `Post`'s title, body, and reactions
  ///
  /// Args:
  ///   data (Post): The data that will be passed to the widget builder.
  ///
  /// Returns:
  ///   A widget that displays the data.
  Widget renderData(Post data) {
    return Center(
      child: ListTile(
        title: Text(data.title),
        subtitle: Text(data.body),
        leading: ElevatedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.heart_broken_outlined),
          label: Text(data.reactions.toString()),
        ),
      ),
    );
  }

  /// > It returns an Observer widget that renders a Text widget with the title
  ///    of the post
  ///
  /// Args:
  ///   controller (PostDetailsViewController): The controller that will be used
  ///   to render the view.
  ///
  /// Returns:
  ///   An Observer widget that will listen to the controller's post stream and
  ///  update the text of the Text widget.
  Observer renderTitle(PostDetailsViewController controller) {
    return Observer(
      builder: (context) => Text(controller.post?.value?.title ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt<PostDetailsViewController>();
    // ignore: cascade_invocations
    controller.fetchPost(postId);

    return Scaffold(
      appBar: AppBar(
        title: renderTitle(controller),
      ),
      body: Observer(
        builder: (context) {
          return controller.post!.asyncValue(
            pending: renderLoading,
            rejected: renderError,
            fulfilled: renderData,
          );
        },
      ),
    );
  }
}
