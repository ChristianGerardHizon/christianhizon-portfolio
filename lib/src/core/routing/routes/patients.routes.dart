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

@TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path)
class PatientPageRoute extends GoRouteData {
  const PatientPageRoute(this.id);
  static const path = '/patient/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPage(id);
  }
}
