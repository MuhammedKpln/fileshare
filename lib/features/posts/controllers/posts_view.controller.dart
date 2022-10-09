import 'package:boilerplate/features/posts/models/base_posts.model.dart';
import 'package:boilerplate/features/posts/repositories/posts.repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'posts_view.controller.g.dart';

/// PostsViewController is a PostsController with a PostsViewController
@LazySingleton()
class PostsViewController = PostsController with _$PostsViewController;

/// The PostsController is an abstract class that extends Store and has a PostsRepository injected into
/// it
abstract class PostsController with Store {
  /// Injecting the PostsRepository into the PostsController.
  PostsController(this._postsRepository) {
    fetchPosts();
  }
  final PostsRepository _postsRepository;

  @observable
  ObservableFuture<BasePosts>? posts;

  @action
  Future<void> fetchPosts() async {
    try {
      final response = _postsRepository.fetchPosts();
      posts = ObservableFuture(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
