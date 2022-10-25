import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// A container with a circle shape, a color, and a circle avatar with an icon
class RoundedIcon extends StatelessWidget {
  // ignore: public_member_api_docs
  const RoundedIcon({super.key, required this.color, required this.icon});

  /// A variable that is being passed in from the parent widget.
  final Color color;

  /// A variable that is being passed in from the parent widget.
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
