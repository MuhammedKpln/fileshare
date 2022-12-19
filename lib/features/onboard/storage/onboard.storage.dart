import 'package:boilerplate/core/storage/constants.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// It saves the state of the onboard page to the onboard box
@LazySingleton()
class OnboardStorage {
  /// > Save the onboard state to the onboard box
  Future<void> saveOnboardState({required bool state}) async {
    final box = await Hive.openLazyBox<bool>(StorageBoxes.onboard.box);

    /// True for hiding, false for showing onboard page.
    await box.put(OnboardBoxKeys.state.name, state);
  }

  /// > Get the onboard state from the onboard box
  ///
  /// Returns:
  ///   A Future<void>
  Future<bool?> getOnboardState() async {
    final box = await Hive.openLazyBox<bool>(StorageBoxes.onboard.box);

    final state = await box.get(OnboardBoxKeys.state.name);

    return state;
  }
}
