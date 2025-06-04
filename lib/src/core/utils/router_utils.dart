import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sannjosevet/src/core/routing/router.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_user.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';

class RouterUtils {
  ///
  /// ignored routes
  ///
  static const ignoredRoutes = <String>[
    LoginPageRoute.path,
    AdminLoginPageRoute.path,
    DomainPageRoute.path,
    SplashPageRoute.path,
  ];

  static FutureOr<String?> redirect(
    BuildContext context,
    GoRouterState state,
    Ref<Object?> ref,
  ) {
    // If the current path is in ignored routes, do not redirect
    final isIgnored =
        ignoredRoutes.any((route) => state.fullPath?.contains(route) ?? false);
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
  }

  static Widget errorBuilder(BuildContext context, GoRouterState state) {
    return const NotFoundRoute().build(context, state);
  }
}
