// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  final int id;
  final UserModel from;
  final UserModel to;
  final int file_count;
  final DateTime created_at;
  const Transfer({
    required this.id,
    required this.from,
    required this.to,
    required this.file_count,
    required this.created_at,
  });

  Transfer copyWith({
    int? id,
    UserModel? from,
    UserModel? to,
    int? file_count,
    DateTime? created_at,
  }) {
    return Transfer(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      file_count: file_count ?? this.file_count,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'file_count': file_count,
      'created_at': created_at.millisecondsSinceEpoch,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    return Transfer(
      id: map['id'] as int,
      from: UserModel.fromMap(map["from"] as Map<String, dynamic>),
      to: UserModel.fromMap(map["to"] as Map<String, dynamic>),
      file_count: map["file_count"] as int,
      created_at: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      from,
      to,
      file_count,
      created_at,
    ];
  }
}
