import 'dart:convert';

import 'package:equatable/equatable.dart';

class FileInformation extends Equatable {
  final String name;
  final num size;
  final String? extension;
  bool transfered;

   FileInformation(
      {required this.name,
      required this.size,
      this.extension,
      this.transfered = false});

  factory FileInformation.fromMap(Map<String, dynamic> data) {
    return FileInformation(
      name: data['name'] as String,
      size: data['size'] as int,
      extension: data['extension'] as String?,
      transfered: data['transfered'] as bool,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'size': size,
        'extension': extension,
        'transfered': transfered,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FileInformation].
  factory FileInformation.fromJson(String data) {
    return FileInformation.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FileInformation] to a JSON string.
  String toJson() => json.encode(toMap());

  FileInformation copyWith({
    String? name,
    int? size,
    String? extension,
    bool? transfered,
  }) {
    return FileInformation(
      name: name ?? this.name,
      size: size ?? this.size,
      extension: extension ?? this.extension,
      transfered: transfered ?? this.transfered,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, size, extension, transfered];
}
