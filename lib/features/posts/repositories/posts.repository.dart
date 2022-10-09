import 'package:boilerplate/features/posts/models/base_posts.model.dart';
import 'package:boilerplate/features/posts/models/post.model.dart';
import 'package:boilerplate/repositories/_base.repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// It's a repository that fetches posts from the API
@LazySingleton()
class PostsRepository extends BaseRepository {
  /// > It makes a GET request to the `/posts` endpoint,
  ///  and if the response is successful, it returns a `BasePosts` object
  ///
  /// Returns:
  ///   A Future<BasePosts>
  Future<BasePosts> fetchPosts() async {
    try {
      final response = await api.get(ApiEndpoints.Posts.path);

      if (response.statusCode == 200) {
        return BasePosts.fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception();
    } on DioError {
      rethrow;
    }
  }

  /// `fetchPost` makes a GET request to the `/posts/:id` endpoint,
  /// and returns a `Post` object if the request is successful
  ///
  /// Args:
  ///   postId (int): The id of the post to fetch.
  ///
  /// Returns:
  ///   A Future<Post>
  Future<Post> fetchPost(int postId) async {
    try {
      final response = await api.get('${ApiEndpoints.Posts.path}/$postId');

      if (response.statusCode == 200) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      }

      throw Exception();
    } on DioError {
      rethrow;
    }
  }
}
