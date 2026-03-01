import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/admin/presentation/pages/admin_profile_page.dart';
import '../../../features/admin/presentation/pages/admin_project_detail_page.dart';
import '../../../features/admin/presentation/pages/admin_projects_page.dart';
import '../../../features/admin/presentation/pages/admin_projects_shell.dart';

part 'admin.routes.g.dart';

/// Admin profile page route.
@TypedGoRoute<AdminProfileRoute>(path: AdminProfileRoute.path)
class AdminProfileRoute extends GoRouteData with $AdminProfileRoute {
  const AdminProfileRoute();

  static const path = '/admin/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminProfilePage();
  }
}

/// Shell route for admin projects (provides two-pane layout on tablet).
@TypedShellRoute<AdminProjectsShellRoute>(
  routes: [
    TypedGoRoute<AdminProjectsRoute>(
      path: AdminProjectsRoute.path,
      routes: [
        TypedGoRoute<AdminProjectDetailRoute>(path: ':id'),
      ],
    ),
  ],
)
class AdminProjectsShellRoute extends ShellRouteData {
  const AdminProjectsShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AdminProjectsShell(child: navigator);
  }
}

/// Admin projects list route.
class AdminProjectsRoute extends GoRouteData with $AdminProjectsRoute {
  const AdminProjectsRoute();

  static const path = '/admin/projects';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminProjectsPage();
  }
}

/// Admin project detail route.
class AdminProjectDetailRoute extends GoRouteData with $AdminProjectDetailRoute {
  const AdminProjectDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminProjectDetailPage(projectId: id);
  }
}
