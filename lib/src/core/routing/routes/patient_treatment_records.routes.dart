part of '../main.routes.dart';

class PatientTreatmentRecordsBranchData extends StatefulShellBranchData {
  const PatientTreatmentRecordsBranchData();
}

@TypedGoRoute<PatientTreatmentRecordsPageRoute>(
    path: PatientTreatmentRecordsPageRoute.path)
class PatientTreatmentRecordsPageRoute extends GoRouteData {
  const PatientTreatmentRecordsPageRoute();
  static const path = '/treatment-records';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox();
  }
}

@TypedGoRoute<PatientTreatmentRecordPageRoute>(
    path: PatientTreatmentRecordPageRoute.path)
class PatientTreatmentRecordPageRoute extends GoRouteData {
  const PatientTreatmentRecordPageRoute(this.id);
  static const path = '/treatment-record/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return PatientTreatmentRecordPage(id);
    return SizedBox();
  }
}
