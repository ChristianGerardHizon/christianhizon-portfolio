import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../pages/app_root.dart';
import 'router_utils.dart';
import 'routes/appointments.routes.dart';
import 'routes/auth.routes.dart';
import 'routes/dashboard.routes.dart';
import 'routes/organization.routes.dart';
import 'routes/patients.routes.dart';
import 'routes/products.routes.dart';
import 'routes/sales.routes.dart';
import 'routes/system.routes.dart';

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
      // Auth routes (outside shell)
      $splashRoute,
      $loginRoute,
      $forgotPasswordRoute,
      $authLoadingRoute,

      // Main app shell with navigation
      ShellRoute(
        builder: (context, state, child) => AppRoot(child: child),
        routes: [
          $dashboardRoute,
          $patientsShellRoute,
          $appointmentsShellRoute,
          $productsRoute,
          $salesRoute,
          $organizationRoute,
          $systemRoute,
        ],
      ),
    ],
  );
}
