import 'dart:async';

import 'package:boilerplate/features/home/models/nearby_device.model.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:unique_name_generator/unique_name_generator.dart';
import 'package:uuid/uuid.dart';
part 'home.controller.g.dart';

/// `HomeViewController` is a singleton that is lazily instantiated and has a
/// `HomeViewControllerBase`
/// as its base class
@LazySingleton(dispose: disposeHomeController)
class HomeViewController = _HomeViewControllerBase with _$HomeViewController;

abstract class _HomeViewControllerBase with Store {
  @observable
  ObservableList<NearbyDevice?> nearbyDevices = ObservableList();

  late NearbyDevice myDeviceInformation;
  late RealtimeChannel channel;

  @action
  void init() {
    FlutterNativeSplash.remove();
    myDeviceInformation =
        NearbyDevice(username: _generateRandomName(), uuid: _generateUuid());
    findNearbyDevices();
  }

  void dispose() {
    channel.send(
      type: RealtimeListenTypes.broadcast,
      payload: myDeviceInformation.toMap(),
      event: 'leave',
    );
    nearbyDevices = ObservableList();

    channel.unsubscribe();
  }

  @action
  Future<void> findNearbyDevices() async {
    final supabase = Supabase.instance.client;
    final ipAddress = await _getIpAddress();
    channel = supabase.channel(
      ipAddress,
      opts: RealtimeChannelConfig(
        key: myDeviceInformation.uuid,
      ),
    );

    channel.on(RealtimeListenTypes.presence, ChannelFilter(event: 'join'),
        (payload, [ref]) {
      final data = NearbyDevice.fromMap(
        payload['newPresences'].first.payload as Map<String, dynamic>,
      );

      if (data.uuid == myDeviceInformation.uuid) {
        return;
      }

      nearbyDevices.add(data);
    }).on(RealtimeListenTypes.presence, ChannelFilter(event: 'leave'), (
      payload, [
      ref,
    ]) {
      final data =
          payload['leftPresences'].first.payload as Map<String, dynamic>;

      nearbyDevices.removeWhere((element) => element?.uuid == data['uuid']);
    }).subscribe((p0, [p1]) async {
      await channel.track(myDeviceInformation.toMap());
    });

    // _joinEvent();
    // _leaveEvent();
  }

  void _leaveEvent() {
    final channelJoinFilters = ChannelFilter(
      event: 'leave',
    );
    channel.on(
      RealtimeListenTypes.broadcast,
      channelJoinFilters,
      (payload, [ref]) {
        final data = NearbyDevice.fromMap(payload as Map<String, dynamic>);

        nearbyDevices.removeWhere((device) => device?.uuid == data.uuid);
      },
    ).subscribe((status, [_]) {
      if (status == 'SUBSCRIBED') {
        _sendUserToPeer(channel);
      }
    });
  }

  void _joinEvent() {
    final channelJoinFilters = ChannelFilter(
      event: 'join',
    );
    channel.on(
      RealtimeListenTypes.broadcast,
      channelJoinFilters,
      (payload, [ref]) {
        final data = NearbyDevice.fromMap(payload as Map<String, dynamic>);
        final userDoesNotExists = nearbyDevices
            .where((element) => element?.uuid == data.uuid)
            .isEmpty;

        if (userDoesNotExists) {
          nearbyDevices.add(data);

          _sendUserToPeer(channel);
        }
      },
    ).subscribe((status, [_]) {
      if (status == 'SUBSCRIBED') {
        _sendUserToPeer(channel);
      }
    });
  }

  void _sendUserToPeer(RealtimeChannel channel) {
    channel.send(
      type: RealtimeListenTypes.broadcast,
      event: 'join',
      payload: myDeviceInformation.toMap(),
    );
  }

  String _generateRandomName() {
    final generator = UniqueNameGenerator(
      dictionaries: [adjectives, names],
      separator: ' ',
      style: NameStyle.capital,
    );
    return generator.generate();
  }

  String _generateUuid() {
    return const Uuid().v4();
  }

  Future<String> _getIpAddress() async {
    final ipv4 = await Ipify.ipv4();

    return ipv4;
  }
}

FutureOr disposeHomeController(HomeViewController instance) {
  instance.dispose();
}
