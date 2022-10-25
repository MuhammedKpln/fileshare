import 'dart:convert';

import 'package:boilerplate/core/storage/types.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.model.g.dart';

@HiveType(typeId: StorageTypeAdapterId.userModel)

/// It's a class that represents a user
class UserModel extends Equatable {
  // ignore: public_member_api_docs
  const UserModel({
    required this.id,
    required this.username,
    // ignore: non_constant_identifier_names
    required this.updated_at,
    this.avatarUrl,
  });

  /// It takes a map and returns a UserModel object.
  ///
  /// Args:
  ///   data (Map<String, dynamic>): The data that is returned from the API.
  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        id: data['id'] as String,
        username: data['username'] as String,
        avatarUrl: data['avatar_url'] as String?,
        updated_at: DateTime.parse(data["updated_at"] as String),
      );

  /// It converts a JSON string into a UserModel object.
  ///
  /// Args:
  ///   data (String): The JSON string that you want to convert to a UserModel
  ///   object.
  ///
  /// Returns:
  ///   A UserModel object

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel.fromMap(data);
  }

  @HiveField(0)

  /// It's a field that is used to store the user's id.
  final String id;
  @HiveField(1)

  /// It's a field that is used to store the user's username.
  final String username;

  /// It's a field that is used to store the user's id.
  @HiveField(2)

  ///  It's a field that is used to store the user's creation date.
  // ignore: non_constant_identifier_names
  final DateTime updated_at;
  @HiveField(3)

  ///  It's a field that is used to store the user's avatar.
  final String? avatarUrl;

  /// It takes a JSON object and returns a User object
  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'avatar_url': avatarUrl,
        'updated_at': updated_at,
      };

  /// It converts the object to a map.
  String toJson() => json.encode(toMap());

  /// If the parameter is null, use the current value, otherwise use the new
  /// value.
  ///
  /// Args:
  ///   id (String): The user's id.
  ///   username (String): The username of the user.
  ///   avatarUrl (String): The URL of the user's avatar.
  ///   updatedAt (String): The date the user was last updated.
  ///
  /// Returns:
  ///   A new UserModel object with the same values as the original,
  ///   except for the ones that are passed
  /// in as arguments.
  UserModel copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      updated_at: updatedAt ?? updated_at,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, username, avatarUrl, updated_at];
}
