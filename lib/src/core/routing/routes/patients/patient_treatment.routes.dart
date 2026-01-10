part of '../../main.routes.dart';

class PatientTreatmentsBranchData extends StatefulShellBranchData {
  const PatientTreatmentsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<PatientTreatmentPageRoute>(
        path: PatientTreatmentPageRoute.path),
    TypedGoRoute<PatientTreatmentFormPageRoute>(
        path: PatientTreatmentFormPageRoute.path),
  ];
}

@TypedGoRoute<PatientTreatmentPageRoute>(path: PatientTreatmentPageRoute.path)
class PatientTreatmentPageRoute extends GoRouteData with $PatientTreatmentPageRoute {
  const PatientTreatmentPageRoute();

  static const path = '/patientTreatments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentsPage();
  }
}

@TypedGoRoute<PatientTreatmentFormPageRoute>(
    path: PatientTreatmentFormPageRoute.path)
class PatientTreatmentFormPageRoute extends GoRouteData with $PatientTreatmentFormPageRoute {
  const PatientTreatmentFormPageRoute({this.id});
  static const path = '/form/patientTreatments';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentFormPage(
      id: id,
    );
  }
}
