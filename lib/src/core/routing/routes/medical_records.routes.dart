part of '../main.routes.dart';

class MedicalRecordsBranchData extends StatefulShellBranchData {
  const MedicalRecordsBranchData();
}

@TypedGoRoute<MedicalRecordsPageRoute>(path: MedicalRecordsPageRoute.path)
class MedicalRecordsPageRoute extends GoRouteData {
  const MedicalRecordsPageRoute(this.id, this.patientId);
  static const path = '/medicalRecords';

  final String id;
  final String patientId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold();
  }
}

@TypedGoRoute<MedicalRecordPageRoute>(path: MedicalRecordPageRoute.path)
class MedicalRecordPageRoute extends GoRouteData {
  const MedicalRecordPageRoute(this.id, this.patientId);
  static const path = '/medicalRecord/:id/:patientId';

  final String id;
  final String patientId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MedicalRecordPage(id: id);
  }
}
