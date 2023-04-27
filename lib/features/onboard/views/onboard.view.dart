import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/features/onboard/controllers/onboard.controller.dart';
import 'package:boilerplate/features/onboard/storage/onboard.storage.dart';
import 'package:boilerplate/routers/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ionicons/ionicons.dart';

@RoutePage()
class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final controller = getIt<OnboardController>();
  final storage = getIt<OnboardStorage>();

  @override
  void initState() {
    super.initState();
    controller.init(onSplashIsAlreadyShowed: onSplashIsAlreadyShowed);
  }

  void onSplashIsAlreadyShowed() {
    context.router.replace(const HomeRoute());
  }

  Future<void> onDone() async {
    await controller.onDone();

    await context.router.replace(const HomeRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: controller.pages,
        next: const Icon(Ionicons.chevron_forward_outline),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700)),
        onDone: onDone,
        globalHeader: AppBar(
          title: const Text('Flyea'),
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10),
          activeSize: const Size(20, 10),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
