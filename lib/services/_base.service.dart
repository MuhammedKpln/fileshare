// ignore_for_file: constant_identifier_names

import 'package:boilerplate/constants%20/services.dart';
import 'package:dio/dio.dart';

/// Api Endpoints
enum ApiEndpoints {
  /// It's a enum that has a path property.
  Todos('/todos');

  /// Endpoint path
  final String path;

  // ignore: public_member_api_docs,sort_constructors_first
  const ApiEndpoints(this.path);
}

/// It's a class that has a Dio object as a property and a getter that returns
/// Dio object
abstract class BaseService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: ServiceConstants.appUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  /// It's a getter that returns the Dio object.
  Dio get api => _dio;
}
