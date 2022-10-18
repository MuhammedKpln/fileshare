import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/features/home/views/components/Card.dart';
import 'package:boilerplate/shared/components/avatar.dart';
import 'package:flutter/material.dart';

class _Appbar extends StatelessWidget {
  const _Appbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '22 jan, 2022',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: ColorPalette.grey.color),
          ),
        ],
      ),
      actions: const [Avatar()],
      toolbarHeight: 100,
    );
  }
}

/// A stateless widget that displays a title, a text, and a button
class HomeViewScreen extends StatelessWidget {
  /// A named constructor.
  const HomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: _Appbar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeCard(
                color: ColorPalette.pink.color,
                onPressed: () => null,
                label: 'Send',
              ),
              HomeCard(
                color: ColorPalette.primary.color,
                onPressed: () => null,
                label: 'Receive',
              )
            ],
          )
        ],
      ),
    );
  }
}
