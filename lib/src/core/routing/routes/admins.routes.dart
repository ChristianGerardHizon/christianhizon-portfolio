part of '../main.routes.dart';

class AdminsBranchData extends StatefulShellBranchData {
  const AdminsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path),
    TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path),
    TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path),
  ];
}

@TypedGoRoute<AdminsPageRoute>(path: AdminsPageRoute.path)
class AdminsPageRoute extends GoRouteData {
  const AdminsPageRoute();
  static const path = '/admins';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AdminsPage();
  }
}

@TypedGoRoute<AdminPageRoute>(path: AdminPageRoute.path)
class AdminPageRoute extends GoRouteData {
  const AdminPageRoute(this.id);
  static const path = '/admin/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminPage(id);
  }
}

@TypedGoRoute<AdminFormPageRoute>(path: AdminFormPageRoute.path)
class AdminFormPageRoute extends GoRouteData {
  const AdminFormPageRoute({this.id});
  static const path = '/form/admin';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminFormPage(id: id);
  }
}
