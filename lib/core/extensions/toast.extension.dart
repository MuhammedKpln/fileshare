// ignore_for_file: constant_identifier_names
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:boilerplate/features/core/app.view.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// It's a class that shows a toast
@LazySingleton()
class Toast {
  /// It shows a snackbar with the text passed in.
  ///
  /// Args:
  ///   text (String): The text to be displayed in the toast.
  ///   toastType (ToastType): This is an enum that I created to define
  ///   the different types of toasts
  ///   that I want to show. Defaults to ToastType
  ///   action (SnackBarAction): This is the action that will be displayed
  ///   on the right side of the snackbar.
  void showToast(
    String text, {
    ToastType? toastType = ToastType.info,
    SnackBarAction? action,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
        backgroundColor: toastType?.color ?? ColorPalette.primary.color,
        action: action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadius.large.radius),
        ),
      ),
    );
  }
}

/// Extending the BuildContext class with a new getter called toast.
extension ToastExtension on BuildContext {
  /// It's a getter that returns a new instance of the _Toast class.
  Toast get toast => Toast();
}
