part of '../main.routes.dart';

class ChangeLogsBranchData extends StatefulShellBranchData {
  const ChangeLogsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path),
    TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path),
    TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path),
  ];
}

@TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path)
class ChangeLogsPageRoute extends GoRouteData with _$ChangeLogsPageRoute {
  const ChangeLogsPageRoute();
  static const path = '/changeLogs';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChangeLogsPage();
  }
}

@TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path)
class ChangeLogPageRoute extends GoRouteData with _$ChangeLogPageRoute {
  const ChangeLogPageRoute(this.id);
  static const path = '/changeLog/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogPage(this.id);
  }
}

@TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path)
class ChangeLogFormPageRoute extends GoRouteData with _$ChangeLogFormPageRoute {
  const ChangeLogFormPageRoute({this.id});
  static const path = '/form/changelog';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogFormPage(id: id);
  }
}
