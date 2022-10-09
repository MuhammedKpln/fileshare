import 'package:boilerplate/features/posts/models/post.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_posts.model.freezed.dart';
part 'base_posts.model.g.dart';

@freezed
class BasePosts with _$BasePosts {
  const factory BasePosts({
    required List<Post> posts,
    required int total,
    required int skip,
    required int limit,
  }) = _BasePosts;

  factory BasePosts.fromJson(Map<String, dynamic> json) =>
      _$BasePostsFromJson(json);
}
