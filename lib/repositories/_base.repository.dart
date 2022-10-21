// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// `SupabaseRepository` is a class that contains a `SupabaseClient` object and
/// a `from` method that returns a `SupabaseQueryBuilder` object
@LazySingleton()
class SupabaseRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// `from` returns a `SupabaseQueryBuilder` object which is used to build
  ///  a query
  ///
  /// Args:
  ///   table (String): The name of the table you want to query.
  ///
  /// Returns:
  ///   SupabaseQueryBuilder
  SupabaseQueryBuilder from({required String table}) {
    return _supabase.from(table);
  }

  /// `auth()` returns a `GoTrueClient` object
  ///
  /// Returns:
  ///   The auth() method returns the GoTrueClient object.
  GoTrueClient auth() {
    return _supabase.auth;
  }
}
