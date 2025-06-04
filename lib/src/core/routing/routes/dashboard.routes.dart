part of '../main.routes.dart';

class DashboardBranchData extends StatefulShellBranchData {
  const DashboardBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<DashboardPageRoute>(path: DashboardPageRoute.path),
  ];
}

@TypedGoRoute<DashboardPageRoute>(path: DashboardPageRoute.path)
class DashboardPageRoute extends GoRouteData {
  const DashboardPageRoute();
  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPage();
  }
}
