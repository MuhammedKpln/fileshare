import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Defining the types of events that can be sent over the WebRTC connection.
enum RTCEventType {
  /// Sender file informations
  fileInformations,

  /// Exchange username
  username,

  /// Sends a notification to sender to return with the next queue.
  fileFetched,

  /// Ping peer to navigate to transfer file
  navigatePing,

  /// Ping peer to notify about leave
  leavePing;

  @override
  String toString() => name.toString();
}

/// It's a class that represents a WebRTC events
class RtcEvent extends Equatable {
  // ignore: public_member_api_docs
  const RtcEvent({required this.event, required this.data});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RtcEvent].
  factory RtcEvent.fromJson(String data) {
    return RtcEvent.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// A factory constructor that takes a Map<String, dynamic> and returns a
  /// RtcEvent object.
  ///
  /// Args:
  ///   data (Map<String, dynamic>): The data to be sent.
  factory RtcEvent.fromMap(Map<String, dynamic> data) => RtcEvent(
        event: RTCEventType.values
            .singleWhere((element) => element.name == data['event']),
        data: data['data'] as Map<String, dynamic>,
      );

  /// It's a named constructor.

  /// It's a named constructor.
  final RTCEventType event;

  /// It's a named constructor.
  final Map<String, dynamic> data;

  /// It returns a map with the event and data fields
  Map<String, dynamic> toMap() => {
        'event': event.toString(),
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
