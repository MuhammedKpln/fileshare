import 'package:auto_route/auto_route.dart';
import 'package:boilerplate/router/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      resolver.next();
    } else {
      router.push(
        const LoginRoute(),
      );
    }
  }
}
