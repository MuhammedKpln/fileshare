import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Defining the types of events that can be sent over the WebRTC connection.
enum RTCEventType {
  /// It's a named constructor.
  fileInformation,

  /// It's a named constructor.
  data
}

/// It's a class that represents a WebRTC events
class RtcEvent extends Equatable {
  // ignore: public_member_api_docs
  const RtcEvent({required this.event, required this.data});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RtcEvent].
  factory RtcEvent.fromJson(Map<String, dynamic> data) {
    return RtcEvent.fromMap(data);
  }

  /// A factory constructor that takes a Map<String, dynamic> and returns a
  /// RtcEvent object.
  ///
  /// Args:
  ///   data (Map<String, dynamic>): The data to be sent.
  factory RtcEvent.fromMap(Map<String, dynamic> data) => RtcEvent(
        event: data['event'] as RTCEventType,
        data: data['data'] as Map<String, dynamic>,
      );

  /// It's a named constructor.

  /// It's a named constructor.
  final RTCEventType event;

  /// It's a named constructor.
  final Map<String, dynamic> data;

  /// It returns a map with the event and data fields
  Map<String, dynamic> toMap() => {
        'event': event,
        'data': data,
      };

  /// `dart:convert`
  ///
  /// Converts [RtcEvent] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [event, data];
}
