import 'package:boilerplate/repositories/enums/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// It's an extension method that is being added to the `AuthException` class.
extension SupabaseCatchErrorSupport on AuthException {
  /// If the error message is in the list of known errors, return the
  ///  error message, otherwise return the unkown error message
  ///
  /// Returns:
  ///   The error message.
  String error() {
    for (final error in SupabaseErrors.values) {
      if (error.errorMessage == message) {
        return error.errorMessage;
      }
    }

    return SupabaseErrors.unkown.errorMessage;
  }
}
