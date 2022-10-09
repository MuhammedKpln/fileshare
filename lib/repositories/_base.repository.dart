// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:boilerplate/core/constants/services.dart';
import 'package:dio/dio.dart';

/// Api Endpoints
enum ApiEndpoints {
  /// It's a enum that has a path property.
  Posts('/posts'),

  /// It's a enum that has a path property.
  AuthLogin('/auth/login');

  /// Endpoint path
  final String path;

  // ignore: public_member_api_docs,sort_constructors_first
  const ApiEndpoints(this.path);
}

/// It's a class that has a Dio object as a property and a getter that returns
/// Dio object
class BaseRepository {
  final Dio _instance = Dio(
    BaseOptions(
      baseUrl: ServiceConstants.apiUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      validateStatus: (status) => status == HttpStatus.ok,
    ),
  );

  /// It's a getter that returns the Dio object.
  Dio get api => _instance;
}
