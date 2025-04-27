part of '../main.routes.dart';

class AppointmentBranchData extends StatefulShellBranchData {
  const AppointmentBranchData();
}

@TypedGoRoute<AppointmentsPageRoute>(path: AppointmentsPageRoute.path)
class AppointmentsPageRoute extends GoRouteData {
  const AppointmentsPageRoute();
  static const path = '/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkInProgressPage();
  }
}
