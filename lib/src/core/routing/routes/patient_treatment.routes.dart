part of '../main.routes.dart';

class PatientTreamentsBranchData extends StatefulShellBranchData {
  const PatientTreamentsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<PatientTreatmentPageRoute>(
        path: PatientTreatmentPageRoute.path),
    TypedGoRoute<PatientTreamentFormPageRoute>(
        path: PatientTreamentFormPageRoute.path),
  ];
}

@TypedGoRoute<PatientTreatmentPageRoute>(path: PatientTreatmentPageRoute.path)
class PatientTreatmentPageRoute extends GoRouteData with _$PatientTreatmentPageRoute {
  const PatientTreatmentPageRoute();

  static const path = '/patientTreaments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentsPage();
  }
}

@TypedGoRoute<PatientTreamentFormPageRoute>(
    path: PatientTreamentFormPageRoute.path)
class PatientTreamentFormPageRoute extends GoRouteData with _$PatientTreamentFormPageRoute {
  const PatientTreamentFormPageRoute({this.id});
  static const path = '/form/patientTreaments';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentFormPage(
      id: id,
    );
  }
}
