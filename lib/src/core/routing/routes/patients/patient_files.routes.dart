part of '../../main.routes.dart';

class PatientFilesBranchData extends StatefulShellBranchData {
  const PatientFilesBranchData();
}

@TypedGoRoute<PatientFileFormPageRoute>(path: PatientFileFormPageRoute.path)
class PatientFileFormPageRoute extends GoRouteData with $PatientFileFormPageRoute {
  const PatientFileFormPageRoute({required this.parentId, this.id});
  static const path = '/form/patientFiles';

  // final String? id;
  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientFileFormPage(
      parentId: parentId,
      id: id,
    );
  }
}
