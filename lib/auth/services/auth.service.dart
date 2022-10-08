import 'dart:io';

import 'package:boilerplate/auth/models/auth.model.dart';
import 'package:boilerplate/services/_base.service.dart';
import 'package:dio/dio.dart';

class AuthService extends BaseService {
  Future<AuthResponse> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    try {
      final response = await api.post(ApiEndpoints.AuthLogin.path, data: data);
      print(response);

      if (response.statusCode == HttpStatus.ok) {
        final data =
            AuthResponse.fromJson(response.data as Map<String, dynamic>);

        return data;
      }

      throw Exception();
    } on DioError {
      rethrow;
    }
  }
}
