import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import 'routes/auth.routes.dart';

/// Utility functions for router configuration.
abstract class RouterUtils {
  /// Routes that should not trigger auth redirects.
  static const List<String> ignoredRoutes = [
    '/login',
    '/splash',
    '/auth-loading',
    '/forgot-password',
  ];

  /// Global redirect function for auth guards.
  ///
  /// Redirects unauthenticated users to login and
  /// authenticated users away from login pages.
  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref ref,
  ) {
    final currentPath = state.matchedLocation;

    // Check if this route should skip auth check
    final isIgnored = ignoredRoutes.any(
      (route) => currentPath.startsWith(route),
    );

    final authAsync = ref.read(authControllerProvider);

    // Auth is loading during login attempt - show auth loading page
    if (authAsync.isLoading && currentPath == LoginRoute.path) {
      return AuthLoadingRoute.path;
    }

    // Still loading auth state on app start - stay on splash
    if (authAsync.isLoading) {
      return SplashRoute.path;
    }

    final isAuthenticated = authAsync.value != null;
    final isOnLoginPage = currentPath == LoginRoute.path;
    final isOnSplashPage = currentPath == SplashRoute.path;
    final isOnAuthLoadingPage = currentPath == AuthLoadingRoute.path;

    // On auth loading page but auth completed (success or error) - redirect appropriately
    if (isOnAuthLoadingPage && !authAsync.isLoading) {
      return isAuthenticated ? '/' : LoginRoute.path;
    }

    // Not authenticated and not on login page - redirect to login
    if (!isAuthenticated && !isOnLoginPage && !isIgnored) {
      return LoginRoute.path;
    }

    // Authenticated but on login or splash - redirect to home
    if (isAuthenticated && (isOnLoginPage || isOnSplashPage)) {
      return '/';
    }

    // No redirect needed
    return null;
  }

  /// Error page builder for unknown routes.
  static Widget errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              '404',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
