import 'package:boilerplate/core/storage/constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// It saves the state of the onboard page to the onboard box
@LazySingleton()
class OnboardStorage {
  /// > Save the onboard state to the onboard box
  Future<void> saveOnboardState({required bool state}) async {
    final box = await Hive.openLazyBox(StorageBoxes.app.box);

    /// True for hiding, false for showing onboard page.
    await box.put(AppBoxKeys.onboardState.name, state);
  }

  /// > Get the onboard state from the onboard box
  ///
  /// Returns:
  ///   A Future<bool?>
  Future<bool?> getOnboardState() async {
    final box = await Hive.openLazyBox(StorageBoxes.app.box);

    final state = await box.get(AppBoxKeys.onboardState.name);

    if (state != null) {
      return state as bool;
    }
    return null;
  }
}
