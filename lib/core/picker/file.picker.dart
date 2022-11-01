import 'package:file_picker/file_picker.dart';

/// It allows the user to pick a file from their device
class FilePickerWrappper {
  final FilePicker _picker = FilePicker.platform;

  /// It allows the user to pick a file from their device.
  ///
  /// Returns:
  ///   A list of PlatformFile objects.
  Future<List<PlatformFile>?> pickFile() async {
    final file = await _picker.pickFiles(
        withData: false, withReadStream: true, allowMultiple: true);

    return file?.files;
  }
}
