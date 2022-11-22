import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/shared/components/core/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

/// An extension method for showing bottom sheet.
extension ShowBottomSheetExtension on BuildContext {
  /// It shows a bottom sheet with a title and a child.
  ///
  /// Args:
  ///   child (Widget): The widget that will be displayed inside the bottomsheet
  ///   title (String): The title of the bottom sheet.
  ///   titleIcon (Widget): The icon to be displayed on the left of the title.
  ///   isDismissible (bool): If true, the bottom sheet can be dismissed by
  ///  tapping the scrim. Defaults
  /// to true
  ///   enableDrag (bool): This is a boolean value that determines whether
  ///  the bottom sheet can be
  /// dragged up and down. Defaults to true
  ///   containerPadding (bool): Toggle padding inside container.
  ///
  /// Returns:
  ///   A Future<void>
  Future<void> showBottomSheet<T>({
    required Widget child,
    required String title,
    Widget? titleIcon,
    bool isDismissible = true,
    bool enableDrag = true,
    bool containerPadding = false,
  }) async {
    await showModalBottomSheet<T>(
      context: this,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeRadius.small.radius),
      ),
      builder: (context) {
        return CustomBottomSheet(
          title: title,
          titleIcon: titleIcon,
          containerPadding: containerPadding,
          child: child,
        );
      },
    );
  }
}
