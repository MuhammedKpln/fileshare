import 'dart:io';

import 'package:boilerplate/features/auth/models/auth.model.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/services/_base.service.dart';
import 'package:dio/dio.dart';

/// It takes an email and password, sends them to the server, and returns the response

class AuthService extends BaseService {
  /// It takes an email and password, sends them to the server, and returns the response
  ///
  /// Args:
  ///   email (String): The email address of the user.
  ///   password (String): The password of the user.
  ///
  /// Returns:
  ///   AuthResponse
  Future<User> login(AuthLoginArgs args) async {
    try {
      final response =
          await api.post(ApiEndpoints.AuthLogin.path, data: args.toJson());

      if (response.statusCode == HttpStatus.ok) {
        final data = User.fromJson(response.data as Map<String, dynamic>);

        return data;
      }

      throw Exception();
    } on DioError catch (err) {
      print(err.response);
      rethrow;
    }
  }
}
