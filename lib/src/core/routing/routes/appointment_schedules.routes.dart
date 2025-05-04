part of '../main.routes.dart';

class AppointmentSchedulesBranchData extends StatefulShellBranchData {
  const AppointmentSchedulesBranchData();
}

@TypedGoRoute<AppointmentSchedulesPageRoute>(path: AppointmentSchedulesPageRoute.path)
class AppointmentSchedulesPageRoute extends GoRouteData {
  const AppointmentSchedulesPageRoute();
  static const path = '/appointments-schedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WorkInProgressPage();
  }
}
