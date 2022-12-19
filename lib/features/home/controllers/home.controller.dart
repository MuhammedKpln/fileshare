import 'dart:async';
import 'dart:io';

import 'package:boilerplate/features/home/models/nearby_device.model.dart';
import 'package:boilerplate/features/home/repository/home.repository.dart';
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
  _HomeViewControllerBase(this._homeRepository);

  final HomeRepository _homeRepository;

  @observable
  ObservableList<NearbyDevice?> nearbyDevices = ObservableList();

  late NearbyDevice myDeviceInformation;
  late NearbyDevice peerDeviceInformation;
  late RealtimeChannel channel;

  @action
  Future<void> init({required void Function(String peerId) onNavigate}) async {
    myDeviceInformation = NearbyDevice(
      username: _generateRandomName(),
      uuid: _generateUuid(),
      platform: Platform.operatingSystem,
    );

    await _findNearbyDevices(onNavigate: onNavigate);
  }

  @action
  void setPeerDevice(NearbyDevice device) {
    peerDeviceInformation = device;
  }

  @action
  Future<void> _findNearbyDevices({
    required void Function(String peerId) onNavigate,
  }) async {
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
    }).on(
      RealtimeListenTypes.broadcast,
      ChannelFilter(event: 'navigate'),
      (payload, [ref]) {
        onNavigate(payload['uuid'] as String);
      },
    ).subscribe((p0, [p1]) async {
      await channel.track(myDeviceInformation.toMap());
    });
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
    final request = await _homeRepository.fetchIpAddress();

    return request.ip;
  }

  void dispose() {
    channel.unsubscribe();
  }
}

FutureOr disposeHomeController(HomeViewController instance) {
  instance.dispose();
}
