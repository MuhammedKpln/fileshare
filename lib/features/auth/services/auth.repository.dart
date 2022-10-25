import 'package:boilerplate/core/logger/logger.dart';
import 'package:boilerplate/features/auth/models/auth.model.dart';
import 'package:boilerplate/features/auth/models/user.model.dart';
import 'package:boilerplate/features/auth/storage/auth.adapter.dart';
import 'package:boilerplate/repositories/_base.repository.dart';
import 'package:boilerplate/repositories/enums/supabase.dart';
import 'package:injectable/injectable.dart';

/// It takes an email and password, sends them to the server, and returns the
/// response

@LazySingleton()
class AuthRepository {
  // ignore: public_member_api_docs
  AuthRepository(this.supabase, this._logger);

  /// A dependency injection.
  SupabaseRepository supabase;
  final LogService _logger;

  /// > We use the `signInWithPassword` function from the `supabase` package to
  ///   sign in a user with their
  /// email and password. We then use the `from` function to get the user's
  /// profile from the `users` table
  ///
  /// Args:
  ///   args (AuthLoginArgs): The arguments that are passed in from the client.
  ///
  /// Returns:
  ///   A UserModel object
  Future<AuthModel> login(AuthLoginArgs args) async {
    try {
      final signIn = await supabase
          .auth()
          .signInWithPassword(email: args.email, password: args.password);

      final userProfile = await supabase
          .from(table: SupabaseTables.profiles.name)
          .select()
          .eq('id', signIn.user!.id)
          .single();

      final userModel = UserModel.fromJson(userProfile as Map<String, dynamic>);

      return AuthModel(
        user: userModel,
        accessToken: signIn.session!.accessToken,
        refreshToken: signIn.session!.refreshToken!,
      );
    } catch (e) {
      _logger.error(e);
      rethrow;
    }
  }

  /// `register` calls `signUp` on the `supabase` object, which returns a
  ///  `Future<AuthResponse>`. If the
  /// `Future` resolves, we call `login` with the same `AuthLoginArgs` object.
  ///  If the `Future` rejects, we
  /// rethrow the error
  ///
  /// Args:
  ///   args (AuthLoginArgs): The arguments passed to the function.

  Future<AuthModel> register(AuthRegisterArgs args) async {
    try {
      final register = await supabase.auth().signUp(
        email: args.email,
        password: args.password,
        data: {'username': args.username},
      );

      final user = UserModel(
        id: register.user!.id,
        updated_at: DateTime.parse(register.user!.updatedAt!),
        username: register.user!.userMetadata!['username'] as String,
      );

      return AuthModel(
        user: user,
        accessToken: register.session!.accessToken,
        refreshToken: register.session!.refreshToken!,
      );
    } catch (e) {
      _logger.error(e);
      rethrow;
    }
  }
}
