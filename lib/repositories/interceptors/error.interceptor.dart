import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/logger/logger.dart';
import 'package:dio/dio.dart';

/// If an error occurs, log it and reject the request.
class ErrorInterceptor implements Interceptor {
  final _log = getIt<LogService>();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _log.error(err);

    return handler.reject(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  // ignore: strict_raw_type
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
