import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

class BottomNavigatorTab extends StatelessWidget {
  // ignore: public_member_api_docs
  const BottomNavigatorTab({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
  });

  /// A variable that is used to store the icon data.
  final IconData icon;

  /// A variable that is used to store the label data.
  final String label;

  /// A function that is called when the button is pressed.

  final VoidCallback onPressed;

  /// A variable that is used to store the active state of the button.
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
      color: ColorPalette.primary.color,
    );

    final txtColor = isActive ? Colors.white : ColorPalette.text.color;

    return AnimatedContainer(
      padding: EdgeInsets.all(ThemePadding.low.padding),
      decoration: isActive ? boxDecoration : null,
      duration: Duration(milliseconds: ThemeAnimations.fast.duration),
      width: isActive ? 100 : 50,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: txtColor,
            ),
            if (isActive)
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    color: txtColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
