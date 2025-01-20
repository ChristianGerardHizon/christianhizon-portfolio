part of '../main.routes.dart';

class StaffBranchData extends StatefulShellBranchData {
  const StaffBranchData();
}

@TypedGoRoute<StaffsPageRoute>(path: StaffsPageRoute.path)
class StaffsPageRoute extends GoRouteData {
  const StaffsPageRoute();
  static const path = '/staff';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StaffsPage();
  }
}

@TypedGoRoute<StaffPageRoute>(path: StaffPageRoute.path)
class StaffPageRoute extends GoRouteData {
  const StaffPageRoute(this.id);
  static const path = '/staff/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StaffPage(id);
  }
}

@TypedGoRoute<StaffCreatePageRoute>(path: StaffCreatePageRoute.path)
class StaffCreatePageRoute extends GoRouteData {
  const StaffCreatePageRoute();
  static const path = '/newStaff';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StaffCreatePage();
  }
}

@TypedGoRoute<StaffUpdatePageRoute>(path: StaffUpdatePageRoute.path)
class StaffUpdatePageRoute extends GoRouteData {
  const StaffUpdatePageRoute(this.id);
  static const path = '/updateStaff/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StaffUpdatePage(id);
  }
}
