import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import 'routes/admin.routes.dart';
import 'routes/auth.routes.dart';
import 'routes/portfolio.routes.dart';

/// Utility functions for router configuration.
abstract class RouterUtils {
  /// Routes that require authentication.
  static bool _isAdminRoute(String path) {
    return path.startsWith('/admin');
  }

  /// Global redirect function for auth guards.
  ///
  /// - `/` (portfolio) is the landing page, always accessible
  /// - `/login` is accessible without auth
  /// - `/admin/*` routes require authentication
  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref ref,
  ) {
    final currentPath = state.uri.path;

    final authAsync = ref.read(authControllerProvider);

    // Don't redirect while auth is still loading — the router will
    // refresh automatically when the auth state resolves.
    if (authAsync.isLoading) return null;

    final isAuthenticated = authAsync.value != null;
    final isOnLoginPage = currentPath == LoginRoute.path;
    final isAdminRoute = _isAdminRoute(currentPath);

    // Bare /admin path - redirect to /admin/profile or login
    if (currentPath == '/admin') {
      return isAuthenticated ? AdminProfileRoute.path : LoginRoute.path;
    }

    // Login page - redirect to admin if already authenticated
    if (isOnLoginPage && isAuthenticated) {
      return AdminProfileRoute.path;
    }

    // Admin route - redirect to login if not authenticated
    if (isAdminRoute && !isAuthenticated) {
      return LoginRoute.path;
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
              onPressed: () => const PortfolioRoute().go(context),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
