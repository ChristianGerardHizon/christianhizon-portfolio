import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/strings.g.dart';

part 'organization.routes.g.dart';

/// Organization page route.
@TypedGoRoute<OrganizationRoute>(path: OrganizationRoute.path)
class OrganizationRoute extends GoRouteData with $OrganizationRoute {
  const OrganizationRoute();

  static const path = '/organization';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrganizationPage();
  }
}

/// Organization page content placeholder.
///
/// This is rendered within the [AppRoot] shell which provides
/// the AppBar and navigation. Only the body content is defined here.
class OrganizationPage extends StatelessWidget {
  const OrganizationPage({super.key});

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
              Icons.business,
              size: 80,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              t.navigation.organization,
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
