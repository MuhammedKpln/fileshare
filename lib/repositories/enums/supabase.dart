/// Supabase tables
// ignore_for_file: sort_constructors_first, public_member_api_docs

enum SupabaseTables { profiles, files }

/// It's a way to create a custom error message.
enum SupabaseErrors {
  emailNotConfirmed('Email not confirmed'),
  invalidCredentials('Invalid login credentials'),
  unkown('unkown');

  final String errorMessage;

  const SupabaseErrors(this.errorMessage);
}
