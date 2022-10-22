// ignore_for_file: public_member_api_docs

import 'package:boilerplate/core/storage/types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.model.freezed.dart';
part 'user.model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class UserModel with _$UserModel {
  @HiveType(typeId: StorageTypeAdapterId.userModel)
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String username,
    // ignore: non_constant_identifier_names
    @HiveField(2) String? avatar_url,
    // ignore: non_constant_identifier_names
    @HiveField(3) required DateTime updated_at,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
