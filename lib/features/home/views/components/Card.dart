import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/Button.dart';
import 'package:flutter/material.dart';

class _RoundedIcon extends StatelessWidget {
  const _RoundedIcon({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withRed(100),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.share,
          color: color,
          size: 15,
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.color,
    required this.onPressed,
    required this.label,
  });

  //Todo: document
  //Todo: add icon
  final Color color;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 130,
      ),
      padding: EdgeInsets.all(ThemePadding.large.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _RoundedIcon(
              color: color,
            ),
          ),
          Button(onPressed: onPressed, label: label)
        ],
      ),
    );
  }
}
