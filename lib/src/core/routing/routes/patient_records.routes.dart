part of '../main.routes.dart';

class PatientRecordsBranchData extends StatefulShellBranchData {
  const PatientRecordsBranchData();
}

@TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path)
class PatientRecordPageRoute extends GoRouteData with _$PatientRecordPageRoute {
  const PatientRecordPageRoute(this.id);
  static const path = '/patientRecord/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordPage(id);
  }
}

@TypedGoRoute<PatientRecordFormPageRoute>(path: PatientRecordFormPageRoute.path)
class PatientRecordFormPageRoute extends GoRouteData with _$PatientRecordFormPageRoute {
  const PatientRecordFormPageRoute({required this.parentId, this.id});
  static const path = '/form/patientRecord';

  // final String? id;
  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordFormPage(parentId: parentId, id: id);
  }
}
