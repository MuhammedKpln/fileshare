import 'package:boilerplate/features/posts/models/post.model.dart';
import 'package:boilerplate/features/posts/repositories/posts.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'post_details_view.controller.g.dart';

/// PostsViewController is a PostsController with a PostsViewController
@LazySingleton()
class PostDetailsViewController = PostDetailsController
    with _$PostDetailsViewController;

/// The PostsController is an abstract class that extends Store and has a PostsRepository injected into
/// it
abstract class PostDetailsController with Store {
  /// Injecting the PostsRepository into the PostsController.
  PostDetailsController(
    this._postsRepository,
  );
  final PostsRepository _postsRepository;

  @observable

  /// A Future that is observable.
  ObservableFuture<Post>? post;

  @action

  /// `fetchPost` is an async function that fetches a post from the repository
  ///  and assigns it to the `post` variable
  ///
  /// Args:
  ///   postId (int): The id of the post to fetch.
  Future<void> fetchPost(int postId) async {
    try {
      final response = _postsRepository.fetchPost(1);
      post = ObservableFuture(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
