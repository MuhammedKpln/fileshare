import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/generated/assets.gen.dart';
import 'package:boilerplate/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// It's a stateless widget that displays a Lottie animation, a text and a rich
/// text
class EmptyFilesSection extends StatelessWidget {
  // ignore: public_member_api_docs
  const EmptyFilesSection({
    super.key,
    required this.onTap,
  });

  /// A function that is called when the user taps on the widget.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.animations.empty.lottie(width: 200),
            Text(
              LocaleKeys.noFilesSelectedTxt.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: ColorPalette.grey.color,
                    ),
                children: [
                  const TextSpan(text: 'Please '),
                  TextSpan(
                    text: 'click me ',
                    style: TextStyle(color: ColorPalette.red.color),
                  ),
                  const TextSpan(text: 'to send files.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
