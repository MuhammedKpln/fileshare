import 'package:boilerplate/core/extensions/toast.extension.dart';
import 'package:boilerplate/core/picker/file.picker.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/settings/storage/settings.storage.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'settings.controller.g.dart';

@LazySingleton()
class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  _SettingsControllerBase(this._picker, this._settingsStorage, this._toast);
  final FilePickerWrappper _picker;
  final SettingsStorage _settingsStorage;
  final Toast _toast;

  @observable
  String? downloadDir;

  @action
  Future<void> init() async {
    await _getSavedDownloadDirectory();
  }

  Future<void> _getSavedDownloadDirectory() async {
    final dir = await _settingsStorage.getDownloadDir();
    if (dir != null) {
      downloadDir = dir.split('/').last;
    }
  }

  @action
  Future<void> changeDownloadsDirectory() async {
    final path = await _picker.selectDirectory();

    if (path != null) {
      await _settingsStorage.saveDownloadDirectory(path);
      downloadDir = path.split('/').last;
      _toast.showToast(
        LocaleKeys.savedDownloadsDir.tr(namedArgs: {'dir': downloadDir ?? ''}),
        toastType: ToastType.success,
      );

      return;
    }

    _toast.showToast('Error!');
  }
}
