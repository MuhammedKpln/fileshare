import 'dart:convert';

import 'package:equatable/equatable.dart';

class FileInformation extends Equatable {
  final String name;
  final int size;
  final String? extension;

  const FileInformation({
    required this.name,
    required this.size,
    this.extension,
  });

  factory FileInformation.fromMap(Map<String, dynamic> data) {
    return FileInformation(
      name: data['name'] as String,
      size: data['size'] as int,
      extension: data['extension'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'size': size,
        'extension': extension,
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
  }) {
    return FileInformation(
      name: name ?? this.name,
      size: size ?? this.size,
      extension: extension ?? this.extension,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, size, extension];
}
