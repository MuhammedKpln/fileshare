import 'package:boilerplate/core/di/di.dart';
import 'package:boilerplate/core/logger/logger.dart';
import 'package:boilerplate/features/auth/storage/auth.storage.dart';
import 'package:dio/dio.dart';

/// It intercepts all requests and adds the user's access token to the request
/// headers
class AuthInterceptor implements Interceptor {
  final _authBox = getIt<AuthBox>();
  final _logger = getIt<LogService>();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _logger.error(err);
    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final user = await _authBox.getAuth();

    if (user?.accessToken != null) {
      _logger.info('Sending request with token "${user?.accessToken}"');

      options.headers = {
        ...options.headers,
        'Authorization': 'Bearer ${user?.accessToken}'
      };
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
