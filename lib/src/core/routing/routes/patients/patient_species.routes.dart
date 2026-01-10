part of '../../main.routes.dart';

class PatientSpeciesBranchData extends StatefulShellBranchData {
  const PatientSpeciesBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<PatientSpeciesListPageRoute>(
        path: PatientSpeciesListPageRoute.path),
    TypedGoRoute<PatientSpeciesFormPageRoute>(
        path: PatientSpeciesFormPageRoute.path),
    TypedGoRoute<PatientSpeciesPageRoute>(path: PatientSpeciesPageRoute.path),
  ];
}

@TypedGoRoute<PatientSpeciesListPageRoute>(
    path: PatientSpeciesListPageRoute.path)
class PatientSpeciesListPageRoute extends GoRouteData with $PatientSpeciesListPageRoute {
  const PatientSpeciesListPageRoute();
  static const path = '/patientSpecies';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientSpeciesListPage();
  }
}

@TypedGoRoute<PatientSpeciesFormPageRoute>(
    path: PatientSpeciesFormPageRoute.path)
class PatientSpeciesFormPageRoute extends GoRouteData with $PatientSpeciesFormPageRoute {
  const PatientSpeciesFormPageRoute({this.id});
  static const path = '/form/patientSpecies';

  // final String? id;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientSpeciesFormPage(
      id: id,
    );
  }
}

@TypedGoRoute<PatientSpeciesPageRoute>(path: PatientSpeciesPageRoute.path)
class PatientSpeciesPageRoute extends GoRouteData with $PatientSpeciesPageRoute {
  const PatientSpeciesPageRoute(this.id);
  static const path = '/patientSpecies/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientSpeciesPage(id);
  }
}
