import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_information.freezed.dart';
part 'file_information.g.dart';

@freezed
class FileInformation with _$FileInformation {
  factory FileInformation({
    required String name,
    required int size,
    String? extension,
  }) = _FileInformation;

  factory FileInformation.fromJson(Map<String, dynamic> json) =>
      _$FileInformationFromJson(json);
}
