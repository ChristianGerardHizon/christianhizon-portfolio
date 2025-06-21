part of '../main.routes.dart';


class MoreBranchData extends StatefulShellBranchData {
  const MoreBranchData();
}

@TypedGoRoute<MorePageRoute>(path: MorePageRoute.path)
class MorePageRoute extends GoRouteData with _$MorePageRoute {
  const MorePageRoute();
  static const path = '/more';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MorePage();
  }
}