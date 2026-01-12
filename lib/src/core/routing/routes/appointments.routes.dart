import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/strings.g.dart';

part 'appointments.routes.g.dart';

/// Appointments page route.
@TypedGoRoute<AppointmentsRoute>(path: AppointmentsRoute.path)
class AppointmentsRoute extends GoRouteData with $AppointmentsRoute {
  const AppointmentsRoute();

  static const path = '/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentsPage();
  }
}

/// Appointments page content placeholder.
///
/// This is rendered within the [AppRoot] shell which provides
/// the AppBar and navigation. Only the body content is defined here.
class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              t.navigation.appointments,
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
