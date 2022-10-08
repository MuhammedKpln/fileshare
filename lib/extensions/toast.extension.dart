// ignore_for_file: constant_identifier_names
import 'package:boilerplate/core/theme/palette.dart';
import 'package:boilerplate/core/theme/toast.dart';
import 'package:flutter/material.dart';

/// It's a class that shows a toast
class Toast {
  /// It's a constructor.
  const Toast(this._context);

  /// BuildContext
  final BuildContext _context;

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
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: toastType?.color ?? ColorPalette.primary.color,
        action: action,
      ),
    );
  }
}

/// Extending the BuildContext class with a new getter called toast.
extension ToastExtension on BuildContext {
  /// It's a getter that returns a new instance of the _Toast class.
  Toast get toast => Toast(this);
}
