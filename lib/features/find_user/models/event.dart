import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Defining the types of events that can be sent over the WebRTC connection.
enum RTCEventType {
  /// It's a named constructor.
  fileInformation,

  /// It's a named constructor.
  data
}

@freezed
class RTCEvent with _$RTCEvent {
  factory RTCEvent({
    required RTCEventType event,
    required dynamic data,
  }) = _RTCEvent;

  factory RTCEvent.fromJson(Map<String, dynamic> json) =>
      _$RTCEventFromJson(json);
}
