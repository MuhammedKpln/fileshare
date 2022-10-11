// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// ignore_for_file: public_member_api_docs

import 'package:boilerplate/core/storage/types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@HiveType(typeId: StorageTypeAdapterId.userModel)
@Freezed(makeCollectionsUnmodifiable: false)
abstract class User with _$User {
  const factory User({
    @HiveField(0) required int id,
    @HiveField(1) required String username,
    @HiveField(2) required String email,
    @HiveField(3) required String firstName,
    @HiveField(4) required String lastName,
    @HiveField(5) required String gender,
    @HiveField(6) required String image,
    @HiveField(7) required String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
