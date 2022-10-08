// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:boilerplate/constants/services.dart';
import 'package:dio/dio.dart';

/// Api Endpoints
enum ApiEndpoints {
  /// It's a enum that has a path property.
  Todos('/todos'),

  /// It's a enum that has a path property.
  AuthLogin('/auth/login');

  /// Endpoint path
  final String path;

  // ignore: public_member_api_docs,sort_constructors_first
  const ApiEndpoints(this.path);
}

/// It's a class that has a Dio object as a property and a getter that returns
/// Dio object
class BaseService {
  /// It creates a new instance of Dio.
  BaseService() {
    _instance = Dio(
      BaseOptions(
        baseUrl: ServiceConstants.apiUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        validateStatus: (status) => status == HttpStatus.ok,
      ),
    );
  }
  late final Dio _instance;

  /// It's a getter that returns the Dio object.
  Dio get api => _instance;
}
