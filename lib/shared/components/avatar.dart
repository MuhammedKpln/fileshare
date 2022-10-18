import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Creating a custom data type called AvatarSize.
enum AvatarSize {
  // ignore: public_member_api_docs
  small(50),
  // ignore: public_member_api_docs
  medium(45),
  // ignore: public_member_api_docs
  large(60);

  /// A constant variable that is used to determine the size of the avatar.
  final double size;
  // ignore: public_member_api_docs, sort_constructors_first
  const AvatarSize(this.size);
}

/// The Avatar class is a stateless widget that displays an avatar image
class Avatar extends StatelessWidget {
  // ignore: public_member_api_docs
  const Avatar({
    super.key,
    required this.child,
    this.size = AvatarSize.small,
    this.color,
  });

  /// A nullable type.
  final Widget child;

  /// A constant variable that is used to determine the size of the avatar.
  final AvatarSize size;

  /// A nullable type.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: size.size,
        maxWidth: size.size,
      ),
      padding: EdgeInsets.only(
        left: ThemePadding.small.padding,
        right: ThemePadding.small.padding,
        top: ThemePadding.small.padding,
      ),
      decoration: BoxDecoration(
        color: color ?? ColorPalette.secondary.color,
        borderRadius: BorderRadius.circular(ThemeRadius.medium.radius),
      ),
      child: child,
    );
  }
}
