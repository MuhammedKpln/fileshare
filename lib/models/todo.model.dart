// ignore_for_file: public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.model.freezed.dart';
part 'todo.model.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
