import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../pages/app_root.dart';
import 'router_utils.dart';
import 'routes/admin.routes.dart';
import 'routes/auth.routes.dart';
import 'routes/portfolio.routes.dart';

part 'router.g.dart';

/// Global navigator key for root navigation.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Global ScaffoldMessenger key for showing snackbars on root scaffold.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// Provides the GoRouter instance for the application.
///
/// Configured with auth redirects and error handling.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: PortfolioRoute.path,
    debugLogDiagnostics: true,
    redirect: (context, state) => RouterUtils.redirect(context, state, ref),
    errorBuilder: RouterUtils.errorBuilder,
    routes: [
      // Auth routes (outside shell)
      $splashRoute,
      $loginRoute,
      $forgotPasswordRoute,
      $authLoadingRoute,

      // Public portfolio routes (outside shell, no auth required)
      $portfolioRoute,
      $allProjectsRoute,
      $projectDetailRoute,

      // Admin shell with navigation (auth required)
      ShellRoute(
        builder: (context, state, child) => AppRoot(child: child),
        routes: [
          $adminProfileRoute,
          $adminProjectsShellRoute,
        ],
      ),
    ],
  );

  // Listen to auth state changes and refresh router to re-evaluate redirects
  ref.listen(authControllerProvider, (previous, next) {
    router.refresh();
  });

  return router;
}
