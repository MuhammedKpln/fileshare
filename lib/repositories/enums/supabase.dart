/// Supabase tables
enum SupabaseTables { profiles }

/// It's a way to create a custom error message.
enum SupabaseErrors {
  emailNotConfirmed(''),
  invalidCredentials('Invalid login credentials'),
  unkown('unkown');

  final String errorMessage;

  const SupabaseErrors(this.errorMessage);
}
