import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:boilerplate/shared/components/rounded_icon.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.color,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  //Todo: document
  //Todo: add icon
  final Color color;
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 160,
        minHeight: 200,
      ),
      padding: EdgeInsets.all(ThemePadding.large.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ThemeRadius.large.radius),
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.6)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RoundedIcon(
              color: color,
              icon: icon,
            ),
          ),
          Button(onPressed: onPressed, label: label)
        ],
      ),
    );
  }
}
