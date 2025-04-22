part of '../main.routes.dart';

class SalesBranchData extends StatefulShellBranchData {
  const SalesBranchData();
}

@TypedGoRoute<SalesPageRoute>(path: SalesPageRoute.path)
class SalesPageRoute extends GoRouteData {
  const SalesPageRoute();
  static const path = '/sales';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkInProgressPage();
  }
}
