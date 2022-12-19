import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/onboard/storage/onboard.storage.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobx/mobx.dart';
part 'onboard.controller.g.dart';

@LazySingleton()
class OnboardController = _OnboardControllerBase with _$OnboardController;

abstract class _OnboardControllerBase with Store {
  _OnboardControllerBase(this._storage);
  final OnboardStorage _storage;

  final _texts = <Map<String, dynamic>>[
    {
      'title': LocaleKeys.onboard1Title.tr(),
      'body': LocaleKeys.onboard1Body.tr(),
      'image': DecoratedBox(
        decoration: BoxDecoration(
          color: ColorPalette.primary.color,
          shape: BoxShape.circle,
        ),
        child: Assets.images.flyea.image(
          width: 200,
        ),
      )
    },
    {
      'title': LocaleKeys.onboard2Title.tr(),
      'body': LocaleKeys.onboard2Body.tr(),
      'image': DecoratedBox(
        decoration: BoxDecoration(
          color: ColorPalette.primary.color,
          shape: BoxShape.circle,
        ),
        child: Assets.images.onboard1.svg(
          width: 200,
        ),
      )
    },
    {
      'title': LocaleKeys.onboard3Title.tr(),
      'body': LocaleKeys.onboard3Body.tr(),
      'image': DecoratedBox(
        decoration: BoxDecoration(
          color: ColorPalette.primary.color,
          shape: BoxShape.circle,
        ),
        child: Assets.images.onboard3.svg(
          width: 200,
        ),
      )
    },
    {
      'title': LocaleKeys.onboard4Title.tr(),
      'body': LocaleKeys.onboard4Body.tr(),
      'image': DecoratedBox(
        decoration: BoxDecoration(
          color: ColorPalette.primary.color,
          shape: BoxShape.circle,
        ),
        child: Assets.images.onboard3.svg(
          width: 200,
        ),
      )
    },
  ];

  List<PageViewModel> get pages => _texts
      .map(
        (e) => PageViewModel(
          title: e['title'] as String,
          body: e['body'] as String,
          image: e['image'] as Widget?,
        ),
      )
      .toList();

  Future<void> onDone() async {
    await _storage.saveOnboardState(state: true);
  }

  Future<void> init({
    required Future<dynamic> Function() onSplashIsAlreadyShowed,
  }) async {
    final state = await _storage.getOnboardState();

    if (state != null && state == true) {
      await onSplashIsAlreadyShowed
          .call()
          .whenComplete(FlutterNativeSplash.remove);
    }
  }
}
