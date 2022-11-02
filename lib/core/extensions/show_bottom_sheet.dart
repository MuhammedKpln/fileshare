import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/core/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

extension ShowBottomSheetExtension on BuildContext {
  Future<void> showBottomSheet<T>(
      {required Widget child,
      required String title,
      Widget? titleIcon,
      bool isDismissible = true,
      bool enableDrag = true}) async {
    await showModalBottomSheet<T>(
      context: this,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadius.small.radius)),
      builder: (context) {
        return CustomBottomSheet(
          child: child,
          title: title,
          titleIcon: titleIcon,
        );
      },
    );
  }
}
