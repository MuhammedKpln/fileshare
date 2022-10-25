import 'package:boilerplate/core/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton()

/// It's a wrapper around the [Logger](https://pub.dev/packages/logger)
/// package that allows you to log messages in debug mode
class LogService {
  /// It's a wrapper around the [Logger](https://pub.dev/packages/logger)
  /// package that allows you to log messages in debug mode
  final Logger logger = Logger();

  /// Log a message at level [Level.verbose].
  void verbose(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void debug(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void info(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void warn(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void error(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(
    dynamic message, {
    dynamic error,
    bool showInProd = false,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      return;
    }

    logger.wtf(message, error, stackTrace);
  }
}

/// A way to get the instance of the LogIt class.
final LogService log = getIt<LogService>();
