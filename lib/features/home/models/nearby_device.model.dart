// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// class NearbyDevice {
//   final String username;
//   final String uuid;
//   final String platform;
// }

class NearbyDevice extends Equatable {
  final String username;
  final String uuid;
  final String platform;
  const NearbyDevice({
    required this.username,
    required this.uuid,
    required this.platform,
  });

  NearbyDevice copyWith({
    String? username,
    String? uuid,
    String? platform,
  }) {
    return NearbyDevice(
      username: username ?? this.username,
      uuid: uuid ?? this.uuid,
      platform: platform ?? this.platform,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'uuid': uuid,
      'platform': platform,
    };
  }

  factory NearbyDevice.fromMap(Map<String, dynamic> map) {
    return NearbyDevice(
      username: map['username'] as String,
      uuid: map['uuid'] as String,
      platform: map['platform'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NearbyDevice.fromJson(String source) =>
      NearbyDevice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [username, uuid, platform];
}
