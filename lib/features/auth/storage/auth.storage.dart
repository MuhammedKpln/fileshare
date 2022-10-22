import 'dart:convert';

import 'package:boilerplate/core/storage/constants.dart';
import 'package:boilerplate/features/auth/storage/auth.adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  Future<void> saveUser(AuthModel user) async {
    final box = await fetchBox<AuthModel>(StorageBoxes.auth.box);

    if (box.containsKey(AuthStorageKeys.user.key)) {
      await box.delete(AuthStorageKeys.user.key);
    }

    await box.put(
      AuthStorageKeys.user.key,
      user,
    );
  }

  /// > Get the user from the auth box in the hive database
  ///
  /// Returns:
  ///   A Future<User?>
  Future<AuthModel?> getAuth() async {
    final box = await fetchBox<AuthModel>(StorageBoxes.auth.box);

    if (box.containsKey(AuthStorageKeys.user.key)) {
      final user = box.get(AuthStorageKeys.user.key);

      return user;
    }

    return null;
  }

  /// It opens the auth box, clears it, and then closes it
  Future<void> clear() async {
    const storage = FlutterSecureStorage();
    final box = await fetchBox<AuthModel>(StorageBoxes.auth.box);

    await box.clear();
    await box.close();
    await storage.deleteAll();
  }

  /// > It opens a box if it's already open, or opens it if it's not
  ///
  /// Args:
  ///   boxName (String): The name of the box you want to open.
  ///
  /// Returns:
  ///   A Future<Box<T>>
  Future<Box<T>> fetchBox<T>(String boxName) async {
    Box<T> box;
    final key = await _fetchEncryption();
    if (Hive.isBoxOpen(boxName)) {
      box = Hive.box<T>(boxName);
    } else {
      if (key == null) {
        await _setEncryption();
        return fetchBox<T>(boxName);
      }

      box =
          await Hive.openBox<T>(boxName, encryptionCipher: HiveAesCipher(key));
    }
    return box;
  }

  Future<Uint8List?> _fetchEncryption() async {
    const storage = FlutterSecureStorage();

    final containsKey =
        await storage.containsKey(key: SecureStorageKeys.HiveKey.key);

    if (containsKey) {
      final key = await storage.read(key: SecureStorageKeys.HiveKey.key);

      return base64Decode(key!);
    }

    return null;
  }

  Future<void> _setEncryption() async {
    final key = Hive.generateSecureKey();
    final baseKey = base64Encode(key);
    const storage = FlutterSecureStorage();
    final containsKey =
        await storage.containsKey(key: SecureStorageKeys.HiveKey.key);

    if (containsKey) {
      return;
    }

    await storage.write(key: SecureStorageKeys.HiveKey.key, value: baseKey);
  }
}
