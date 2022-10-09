import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

extension ObservableFutureWhenExtension on ObservableFuture {
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
