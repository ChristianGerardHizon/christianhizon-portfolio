part of '../main.routes.dart';

class PatientPrescriptionItemBranchData extends StatefulShellBranchData {
  const PatientPrescriptionItemBranchData();
}

@TypedGoRoute<PatientPrescriptionItemFormPageRoute>(
    path: PatientPrescriptionItemFormPageRoute.path)
class PatientPrescriptionItemFormPageRoute extends GoRouteData {
  const PatientPrescriptionItemFormPageRoute({required this.parentId, this.id});
  static const path = '/form/patientPrescriptionItem';

  // final String? id;
  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPrescriptionItemFormPage(
      parentId: parentId,
      id: id,
    ); // const PatientPrescriptionItemFormPage();
  }
}
