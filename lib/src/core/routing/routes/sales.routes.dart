part of '../main.routes.dart';

class SalesBranchData extends StatefulShellBranchData {
  const SalesBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<SalesPageRoute>(path: SalesPageRoute.path),
  ];
}

@TypedGoRoute<SalesPageRoute>(path: SalesPageRoute.path)
class SalesPageRoute extends GoRouteData with _$SalesPageRoute {
  const SalesPageRoute();
  static const path = '/sales';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkInProgressPage();
  }
}

class SalesCashierBranchData extends StatefulShellBranchData {
  const SalesCashierBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<SalesCashierPageRoute>(path: SalesCashierPageRoute.path),
  ];
}

@TypedGoRoute<SalesCashierPageRoute>(path: SalesCashierPageRoute.path)
class SalesCashierPageRoute extends GoRouteData with _$SalesCashierPageRoute {
  const SalesCashierPageRoute();
  static const path = '/cashier';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkInProgressPage();
  }
}
