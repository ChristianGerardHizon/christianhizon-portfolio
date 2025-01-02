part of '../main.routes.dart';

class PatientsBranchData extends StatefulShellBranchData {
  const PatientsBranchData();
}

@TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path)
class PatientsPageRoute extends GoRouteData {
  const PatientsPageRoute();
  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientsPage();
  }
}
