import 'package:boilerplate/core/storage/types.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:hive/hive.dart';

part 'auth.adapter.g.dart';

/// This class is a way to tell Hive how to store the data.
@HiveType(typeId: StorageTypeAdapterId.authAdapterModel)
class AuthModel {
  /// A constructor.
  AuthModel({required this.user, required this.accessToken});

  /// User
  @HiveField(0)
  final User user;

  /// Access token
  @HiveField(1)
  final String accessToken;
}
