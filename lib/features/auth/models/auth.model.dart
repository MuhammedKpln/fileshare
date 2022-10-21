// ignore_for_file: public_member_api_docs

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.model.freezed.dart';
part 'auth.model.g.dart';

@freezed
class AuthLoginArgs with _$AuthLoginArgs {
  factory AuthLoginArgs({
    required String email,
    required String password,
  }) = _AuthLoginArgs;

  factory AuthLoginArgs.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginArgsFromJson(json);
}

@freezed
class AuthRegisterModel with _$AuthRegisterModel {
  factory AuthRegisterModel({
    required String email,
    required String username,
    required String password,
  }) = _AuthRegisterModel;

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$AuthRegisterModelFromJson(json);
}
