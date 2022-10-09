import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.model.freezed.dart';
part 'auth.model.g.dart';

@freezed
class AuthLoginArgs with _$AuthLoginArgs {
  factory AuthLoginArgs({
    required String username,
    required String password,
  }) = _AuthLoginArgs;

  factory AuthLoginArgs.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginArgsFromJson(json);
}
