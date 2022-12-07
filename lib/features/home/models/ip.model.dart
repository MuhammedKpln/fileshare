// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class IpService extends Equatable {
  final String ip;
  const IpService({
    required this.ip,
  });

  IpService copyWith({
    String? ip,
  }) {
    return IpService(
      ip: ip ?? this.ip,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ip': ip,
    };
  }

  factory IpService.fromMap(Map<String, dynamic> map) {
    return IpService(
      ip: map['ip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IpService.fromJson(String source) =>
      IpService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ip];
}
