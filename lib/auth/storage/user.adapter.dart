import 'package:hive/hive.dart';

part 'user.adapter.g.dart';

/// A Hive adapter for the User class.
@HiveType(typeId: 0)
class User {
  /// A constructor that takes in a token.
  User(this.token);

  /// A variable that is used to store the token.
  @HiveField(0)
  String token;
}
