part of '../main.routes.dart';

class PatientTreatmentRecordsBranchData extends StatefulShellBranchData {
  const PatientTreatmentRecordsBranchData();
}

@TypedGoRoute<PatientTreatmentRecordPageRoute>(
    path: PatientTreatmentRecordPageRoute.path)
class PatientTreatmentRecordPageRoute extends GoRouteData {
  const PatientTreatmentRecordPageRoute(this.id);
  static const path = '/patientTreatmentRecord/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordPage(id);
  }
}

@TypedGoRoute<PatientTreatmentsRecordPageRoute>(
    path: PatientTreatmentsRecordPageRoute.path)
class PatientTreatmentsRecordPageRoute extends GoRouteData {
  const PatientTreatmentsRecordPageRoute(this.id);
  static const path = '/patientTreatmentRecords';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordsPage(id: id);
  }
}

@TypedGoRoute<PatientTreatmentRecordFormPageRoute>(
    path: PatientTreatmentRecordFormPageRoute.path)
class PatientTreatmentRecordFormPageRoute extends GoRouteData {
  const PatientTreatmentRecordFormPageRoute({required this.parentId, this.id});
  static const path = '/form/patientTreatmentRecord';

  // final String? id;
  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordFormPage(parentId: parentId, id: id);
  }
}
