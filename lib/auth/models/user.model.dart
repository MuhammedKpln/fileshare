// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@freezed

/// `User` is a class that has a factory constructor that takes in a map of
///  strings to dynamic objects and returns a `User` object
class User with _$User {
  /// A factory constructor that takes in a map of strings to dynamic objects
  /// and returns a `User` object
  factory User({
    required int id,
    required String email,
    required String first_name,
    required String last_name,
    required String avatar,
  }) = _User;

  /// It converts a JSON string into a Dart object.
  ///
  /// Args:
  ///   json (Map<String, dynamic>): The JSON string that you want to convert
  ///   to a Dart object.

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
