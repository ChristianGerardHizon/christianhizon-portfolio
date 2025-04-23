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
  const PatientPageRoute(this.id, {this.page = 0});
  static const path = '/patient/:id';

  final String id;
  final int page;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPage(id, page: 0);
  }
}

@TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path)
class PatientFormPageRoute extends GoRouteData {
  const PatientFormPageRoute({this.id});
  static const path = '/form/patient';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientFormPage(id: id);
  }
}

@TypedGoRoute<PatientPatientRecordPageRoute>(
    path: PatientPatientRecordPageRoute.path)
class PatientPatientRecordPageRoute extends GoRouteData {
  const PatientPatientRecordPageRoute({required this.patientRecordId});
  static const path = '/patientRecord/:patientRecordId';

  final String patientRecordId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordPage(id: patientRecordId);
  }
}
