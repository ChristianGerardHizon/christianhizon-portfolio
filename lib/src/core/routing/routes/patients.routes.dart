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

@TypedGoRoute<PatientCreatePageRoute>(path: PatientCreatePageRoute.path)
class PatientCreatePageRoute extends GoRouteData {
  const PatientCreatePageRoute();
  static const path = '/newPatient';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientCreatePage();
  }
}

@TypedGoRoute<PatientUpdatePageRoute>(path: PatientUpdatePageRoute.path)
class PatientUpdatePageRoute extends GoRouteData {
  const PatientUpdatePageRoute(this.id);
  static const path = '/updatePatient/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientUpdatePage(id);
  }
}
