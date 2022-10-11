import 'package:boilerplate/features/posts/models/post.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_posts.model.freezed.dart';
part 'base_posts.model.g.dart';

@freezed

/// `BasePosts` is a class that has a `posts` property of type `List<Post>`, a
///  `total` property of type
/// `int`, a `skip` property of type `int`, and a `limit` property of type `int`
class BasePosts with _$BasePosts {
  /// A constructor that takes in a list of posts, a total, a skip, and a limit.
  const factory BasePosts({
    required List<Post> posts,
    required int total,
    required int skip,
    required int limit,
  }) = _BasePosts;

  /// It converts the json data into a dart object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON string that you want to convert
  ///  to a Dart object.

  factory BasePosts.fromJson(Map<String, dynamic> json) =>
      _$BasePostsFromJson(json);
}
