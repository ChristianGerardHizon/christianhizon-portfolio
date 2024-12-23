import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
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
    DomainPageRoute.path,
  ];

  // final storeOwnerRoutes = <String>[];

  return GoRouter(
    initialLocation: RootRoute.path,
    debugLogDiagnostics: false,
    navigatorKey: rootKey,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);

      final isAuthenticated = auth.valueOrNull is AuthUser;
      final isLoading = auth is AsyncLoading;

      ///
      /// authentication
      ///

      if (isLoading) return SplashPageRoute.path;

      // if fullPath is found in ignoredRoutes
      final results = ignoredRoutes.where(
        (x) => state.fullPath?.contains(x) ?? false,
      );
      if (results.isNotEmpty) return null;

      if (isAuthenticated) return null;

      return LoginPageRoute.path;
    },
    routes: $appRoutes,
    errorBuilder: const NotFoundRoute().build,
  );
}
