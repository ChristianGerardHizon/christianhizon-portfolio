import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/features/authentication/domain/auth_admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'main.routes.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  ///
  /// ignored routes
  ///
  final ignoredRoutes = <String>[
    LoginPageRoute.path,
    AdminLoginPageRoute.path,
    DomainPageRoute.path,
    SplashPageRoute.path,
  ];

  // final storeOwnerRoutes = <String>[];

  return GoRouter(
    initialLocation: RootRoute.path,
    debugLogDiagnostics: true,
    navigatorKey: rootKey,
    redirect: (context, state) {
      final ignoredRoutes = <String>[
        LoginPageRoute.path,
        AdminLoginPageRoute.path,
        DomainPageRoute.path,
        SplashPageRoute.path,
      ];

      // If the current path is in ignored routes, do not redirect
      final isIgnored = ignoredRoutes
          .any((route) => state.fullPath?.contains(route) ?? false);
      if (isIgnored) return null;

      final authAsync = ref.read(authControllerProvider);

      // If auth is still loading, show splash screen
      if (authAsync.isLoading) {
        return SplashPageRoute.path;
      }

      // If auth has an error or no user is found, go to login page
      if (authAsync.hasError || authAsync.value == null) {
        return LoginPageRoute.path;
      }

      // Authenticated user
      final authData = authAsync.value;

      if (authData is AuthUser && authData.record.verified != true) {
        return EmailValidationPageRoute.path;
      }

      if (authData is AuthAdmin && authData.record.verified != true) {
        return EmailValidationPageRoute.path;
      }

      // All checks passed, continue with normal routing
      return null;
    },
    routes: $appRoutes,
    errorBuilder: const NotFoundRoute().build,
  );
}
