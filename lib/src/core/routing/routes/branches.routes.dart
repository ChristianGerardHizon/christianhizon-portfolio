part of '../main.routes.dart';

class BranchesBranchData extends StatefulShellBranchData {
  const BranchesBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path),
    TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path),
    TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path),
  ];
}

@TypedGoRoute<BranchesPageRoute>(path: BranchesPageRoute.path)
class BranchesPageRoute extends GoRouteData with $BranchesPageRoute {
  const BranchesPageRoute();
  static const path = '/branches';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BranchesPage();
  }
}

@TypedGoRoute<BranchFormPageRoute>(path: BranchFormPageRoute.path)
class BranchFormPageRoute extends GoRouteData with $BranchFormPageRoute {
  const BranchFormPageRoute({this.id});
  static const path = '/form/branch';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchFormPage(id: id);
  }
}

@TypedGoRoute<BranchPageRoute>(path: BranchPageRoute.path)
class BranchPageRoute extends GoRouteData with $BranchPageRoute {
  const BranchPageRoute(this.id);
  static const path = '/branch/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BranchPage(id);
  }
}
