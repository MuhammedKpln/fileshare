// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class AuthLoginArgs extends Equatable {
  const AuthLoginArgs({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterArgs extends Equatable {
  const AuthRegisterArgs({
    required this.email,
    required this.username,
    required this.password,
  });

  final String email;
  final String username;
  final String password;

  @override
  List<Object?> get props => [email, username, password];
}
