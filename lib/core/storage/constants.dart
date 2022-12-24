// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Hive box names
enum StorageBoxes {
  app('app');

  final String box;
  const StorageBoxes(this.box);
}

/// Onboard box keys
enum AppBoxKeys { onboardState, downloadDir }

/// Hive box names
enum SecureStorageKeys {
  hiveKey('HIVE_ENC_KEY');

  final String key;
  const SecureStorageKeys(this.key);
}
