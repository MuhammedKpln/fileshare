import 'package:boilerplate/core/storage/constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// It saves the state of the onboard page to the onboard box
@LazySingleton()
class SettingsStorage {
  /// It opens the app box, and saves the download directory to it
  ///
  /// Args:
  ///   dir (String): The directory to save.
  Future<void> saveDownloadDirectory(String dir) async {
    final box = Hive.lazyBox(StorageBoxes.app.box);

    await box.put(AppBoxKeys.downloadDir.name, dir);
  }

  /// > Get the value of the `downloadDir` key from the `app` box
  ///
  /// Returns:
  ///   A Future<String?>
  Future<String?> getDownloadDir() async {
    final box = Hive.lazyBox(StorageBoxes.app.box);

    final state = await box.get(AppBoxKeys.downloadDir.name);

    return state as String;
  }
}
