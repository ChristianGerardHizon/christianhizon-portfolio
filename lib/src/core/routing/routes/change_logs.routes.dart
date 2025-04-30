part of '../main.routes.dart';

class ChangeLogsBranchData extends StatefulShellBranchData {
  const ChangeLogsBranchData();
}

@TypedGoRoute<ChangeLogsPageRoute>(path: ChangeLogsPageRoute.path)
class ChangeLogsPageRoute extends GoRouteData {
  const ChangeLogsPageRoute();
  static const path = '/changeLogs';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChangeLogsPage();
  }
}

@TypedGoRoute<ChangeLogPageRoute>(path: ChangeLogPageRoute.path)
class ChangeLogPageRoute extends GoRouteData {
  const ChangeLogPageRoute(this.id);
  static const path = '/changeLog/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogPage(this.id);
  }
}

@TypedGoRoute<ChangeLogFormPageRoute>(path: ChangeLogFormPageRoute.path)
class ChangeLogFormPageRoute extends GoRouteData {
  const ChangeLogFormPageRoute({this.id});
  static const path = '/form/changelog';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChangeLogFormPage(id: id);
  }
}
