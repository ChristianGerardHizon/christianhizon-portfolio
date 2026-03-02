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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF02569B),
                  letterSpacing: -2,
                  height: 1,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Page not found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The page you\'re looking for doesn\'t exist or has been moved.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF0F172A).withValues(alpha: 0.5),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => const PortfolioRoute().go(context),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF02569B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
