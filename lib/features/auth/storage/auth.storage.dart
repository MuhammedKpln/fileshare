import 'package:boilerplate/core/storage/constants.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// It saves a user to a box
@LazySingleton()
class AuthBox {
  /// > It opens the `auth` box, deletes the `user` key if it exists
  /// and then saves the `user` key with  the `token` value
  ///
  /// Args:
  ///   token (String): The token that you get from the server.
  Future<void> saveUser(User user) async {
    final box = await Hive.openLazyBox<User>(StorageBoxes.auth.box);

    if (box.containsKey(AuthStorageKeys.user.key)) {
      await box.delete(AuthStorageKeys.user.key);
    }

    await box.put(AuthStorageKeys.user.key, user);
  }

  /// > Get the user from the auth box in the hive database
  ///
  /// Returns:
  ///   A Future<User?>
  Future<User?> getUser() async {
    final box = await Hive.openLazyBox<User>(StorageBoxes.auth.box);
    if (box.containsKey(AuthStorageKeys.user.key)) {
      final user = await box.get(AuthStorageKeys.user.key);

      return user;
    }

    return null;
  }

  /// It opens the auth box, clears it, and then closes it
  Future<void> clear() async {
    final box = await Hive.openLazyBox<User>(StorageBoxes.auth.box);

    await box.clear();
    await box.close();
  }
}
