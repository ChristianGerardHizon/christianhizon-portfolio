import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import 'router_utils.dart';
import 'routes/auth.routes.dart';
import 'routes/dashboard.routes.dart';

part 'router.g.dart';

/// Global navigator key for root navigation.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Provides the GoRouter instance for the application.
///
/// Configured with auth redirects and error handling.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Watch auth state to trigger router refresh on auth changes
  ref.listen(authControllerProvider, (previous, next) {
    if (next.isLoading) return;

    ref.invalidateSelf();
  });
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: SplashRoute.path,
    debugLogDiagnostics: true,
    redirect: (context, state) => RouterUtils.redirect(context, state, ref),
    errorBuilder: RouterUtils.errorBuilder,
    routes: [
      // Auth routes
      $splashRoute,
      $loginRoute,
      $forgotPasswordRoute,
      $authLoadingRoute,

      // Main app routes
      $dashboardRoute,
    ],
  );
}
