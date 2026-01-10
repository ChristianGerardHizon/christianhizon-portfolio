part of '../../main.routes.dart';

/// Patient Config Branch - consolidates species, breeds, and treatments catalog
class PatientConfigBranchData extends StatefulShellBranchData {
  const PatientConfigBranchData();

  static const routes = <TypeRouteData>[
    // Species
    TypedGoRoute<PatientSpeciesListPageRoute>(
        path: PatientSpeciesListPageRoute.path),
    TypedGoRoute<PatientSpeciesPageRoute>(path: PatientSpeciesPageRoute.path),
    TypedGoRoute<PatientSpeciesFormPageRoute>(
        path: PatientSpeciesFormPageRoute.path),
    // Breeds
    TypedGoRoute<PatientBreedFormPageRoute>(
        path: PatientBreedFormPageRoute.path),
    // Treatments Catalog
    TypedGoRoute<PatientTreatmentPageRoute>(
        path: PatientTreatmentPageRoute.path),
    TypedGoRoute<PatientTreatmentFormPageRoute>(
        path: PatientTreatmentFormPageRoute.path),
  ];
}

// =============================================================================
// Species Routes
// =============================================================================

@TypedGoRoute<PatientSpeciesListPageRoute>(
    path: PatientSpeciesListPageRoute.path)
class PatientSpeciesListPageRoute extends GoRouteData
    with $PatientSpeciesListPageRoute {
  const PatientSpeciesListPageRoute();
  static const path = '/patient-config/species';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientSpeciesListPage();
  }
}

@TypedGoRoute<PatientSpeciesPageRoute>(path: PatientSpeciesPageRoute.path)
class PatientSpeciesPageRoute extends GoRouteData with $PatientSpeciesPageRoute {
  const PatientSpeciesPageRoute(this.id);
  static const path = '/patient-config/species/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientSpeciesPage(id);
  }
}

@TypedGoRoute<PatientSpeciesFormPageRoute>(
    path: PatientSpeciesFormPageRoute.path)
class PatientSpeciesFormPageRoute extends GoRouteData
    with $PatientSpeciesFormPageRoute {
  const PatientSpeciesFormPageRoute({this.id});
  static const path = '/patient-config/species/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientSpeciesFormPage(
      id: id,
    );
  }
}

// =============================================================================
// Breeds Routes
// =============================================================================

@TypedGoRoute<PatientBreedFormPageRoute>(path: PatientBreedFormPageRoute.path)
class PatientBreedFormPageRoute extends GoRouteData
    with $PatientBreedFormPageRoute {
  const PatientBreedFormPageRoute({this.id, required this.parentId});
  static const path = '/patient-config/breeds/form';

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientBreedFormPage(
      id: id,
      parentId: parentId,
    );
  }
}

// =============================================================================
// Treatments Catalog Routes
// =============================================================================

@TypedGoRoute<PatientTreatmentPageRoute>(path: PatientTreatmentPageRoute.path)
class PatientTreatmentPageRoute extends GoRouteData
    with $PatientTreatmentPageRoute {
  const PatientTreatmentPageRoute();

  static const path = '/patient-config/treatments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentsPage();
  }
}

@TypedGoRoute<PatientTreatmentFormPageRoute>(
    path: PatientTreatmentFormPageRoute.path)
class PatientTreatmentFormPageRoute extends GoRouteData
    with $PatientTreatmentFormPageRoute {
  const PatientTreatmentFormPageRoute({this.id});
  static const path = '/patient-config/treatments/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentFormPage(
      id: id,
    );
  }
}
