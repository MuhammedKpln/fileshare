// lib/env/env.dart
// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField()
  static const SUPABASE_URL = _Env.SUPABASE_URL;
  @EnviedField()
  static const SUPABASE_KEY = _Env.SUPABASE_KEY;
}
