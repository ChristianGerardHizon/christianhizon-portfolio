part of '../main.routes.dart';

class AdminsBranchData extends StatefulShellBranchData {
  const AdminsBranchData();
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
    return AdminPage(id: id);
  }
}
