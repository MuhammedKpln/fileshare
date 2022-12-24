import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

/// It allows the user to pick a file from their device
@LazySingleton()
class FilePickerWrappper {
  final FilePicker _picker = FilePicker.platform;

  /// It allows the user to pick a file from their device.
  ///
  /// Returns:
  ///   A list of PlatformFile objects.
  Future<List<PlatformFile>?> pickFile() async {
    final file = await _picker.pickFiles(
      withReadStream: true,
      allowMultiple: true,
    );

    return file?.files;
  }

  /// It opens a file picker and returns the path of the selected directory.
  ///
  /// Returns:
  ///   A Future<String?>
  Future<String?> selectDirectory() async {
    final file = _picker.getDirectoryPath();

    return file;
  }
}
