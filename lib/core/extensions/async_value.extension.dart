import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

/// It's an extension method that can be used on ObservableFuture.
extension ObservableFutureWhenExtension on ObservableFuture<dynamic> {
  /// If the future is pending, return the pending widget,
  /// if the future is rejected, return the rejected widget,
  /// if the future is fulfilled, return the fulfilled widget.
  ///
  /// Args:
  ///   pending (Widget Function()): A function that returns a widget to be
  /// displayed while the future is still pending.
  ///   fulfilled (Widget Function(T data)): A function that returns a widget to
  ///  be displayed when the future is fulfilled.
  ///   rejected (Widget Function(dynamic error)): A function that returns a
  /// widget to be displayed when the future is rejected.
  ///
  /// Returns:
  ///   A widget.
  Widget asyncValue<T>({
    required Widget Function() pending,
    required Widget Function(T data) fulfilled,
    required Widget Function(dynamic error) rejected,
  }) {
    switch (status) {
      case FutureStatus.pending:
        return pending.call();
      case FutureStatus.rejected:
        return rejected.call(error);
      case FutureStatus.fulfilled:
        return fulfilled.call(value as T);
    }
  }
}
