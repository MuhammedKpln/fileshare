import 'package:boilerplate/core/storage/types.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'auth.adapter.g.dart';

/// This class is a way to tell Hive how to store the data.
@HiveType(typeId: StorageTypeAdapterId.authAdapterModel)
class AuthModel extends Equatable {
  /// A constructor.
  const AuthModel({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  /// User
  @HiveField(0)
  final UserModel user;

  /// Access token
  @HiveField(1)
  final String accessToken;

  /// Access token
  @HiveField(2)
  final String refreshToken;

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
