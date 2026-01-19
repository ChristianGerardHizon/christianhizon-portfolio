import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/users/presentation/pages/user_roles_page.dart';

part 'roles.routes.g.dart';

/// Top-level route for User Roles management.
@TypedGoRoute<RolesRoute>(path: RolesRoute.path)
class RolesRoute extends GoRouteData with $RolesRoute {
  const RolesRoute();

  static const path = '/roles';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UserRolesPage();
  }
}
