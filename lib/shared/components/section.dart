import 'package:boilerplate/core/theme/palette.dart';
import 'package:flutter/material.dart';

/// `Section` is a widget that displays a title and a child
class Section extends StatelessWidget {
  // ignore: public_member_api_docs
  const Section({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing = const SizedBox.shrink(),
  });

  /// Section title
  final String title;

  /// Section subtitle
  final String? subtitle;

  /// Trailing for title
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ThemePadding.medium.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: ThemePadding.medium.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing ?? const SizedBox.shrink()
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
