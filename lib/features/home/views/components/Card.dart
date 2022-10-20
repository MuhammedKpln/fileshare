import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/button.dart';
import 'package:flutter/material.dart';

class _RoundedIcon extends StatelessWidget {
  const _RoundedIcon({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ThemePadding.medium.padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Icon(
          icon,
          color: color,
          size: 25,
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
            child: _RoundedIcon(
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
