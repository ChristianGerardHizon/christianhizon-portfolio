part of '../main.routes.dart';

class PatientRecordsBranchData extends StatefulShellBranchData {
  const PatientRecordsBranchData();
}

@TypedGoRoute<PatientRecordsPageRoute>(path: PatientRecordsPageRoute.path)
class PatientRecordsPageRoute extends GoRouteData {
  const PatientRecordsPageRoute(this.id, this.patientId);
  static const path = '/patientRecords';

  final String id;
  final String patientId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold();
  }
}

@TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path)
class PatientRecordPageRoute extends GoRouteData {
  const PatientRecordPageRoute(this.id, this.patientId);
  static const path = '/patientRecord/:id/:patientId';

  final String id;
  final String patientId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordPage(id: id);
  }
}
