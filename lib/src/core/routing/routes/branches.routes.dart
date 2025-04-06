part of '../main.routes.dart';

class BranchesBranchData extends StatefulShellBranchData {
  const BranchesBranchData();
}

@TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path)
class BranchesPageRoute extends GoRouteData {
  const BranchesPageRoute();
  static const path = '/branches';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BranchesPage();
  }
}

@TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path)
class BranchFormPageRoute extends GoRouteData {
  const BranchFormPageRoute({this.id});
  static const path = '/form/branch';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchFormPage(id: id);
  }
}

@TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path)
class BranchPageRoute extends GoRouteData {
  const BranchPageRoute(this.id);
  static const path = '/branch/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchPage(id);
  }
}
