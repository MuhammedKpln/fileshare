import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({required this.color, required this.icon});

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
