part of '../../main.routes.dart';

/// Patients Branch - core patient management, records, treatment records,
/// prescriptions, and files
class PatientsBranchData extends StatefulShellBranchData {
  const PatientsBranchData();

  static const routes = <TypeRouteData>[
    // Patient Core
    TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path),
    TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),
    TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path),
    // Patient Records
    TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path),
    TypedGoRoute<PatientRecordFormPageRoute>(
        path: PatientRecordFormPageRoute.path),
    // Patient Treatment Records
    TypedGoRoute<PatientTreatmentsRecordPageRoute>(
        path: PatientTreatmentsRecordPageRoute.path),
    TypedGoRoute<PatientTreatmentRecordPageRoute>(
        path: PatientTreatmentRecordPageRoute.path),
    TypedGoRoute<PatientTreatmentRecordFormPageRoute>(
        path: PatientTreatmentRecordFormPageRoute.path),
    // Patient Prescription Item
    TypedGoRoute<PatientPrescriptionItemFormPageRoute>(
        path: PatientPrescriptionItemFormPageRoute.path),
    // Patient Files
    TypedGoRoute<PatientFileFormPageRoute>(path: PatientFileFormPageRoute.path),
  ];
}

// =============================================================================
// Patient Core Routes
// =============================================================================

@TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path)
class PatientsPageRoute extends GoRouteData with $PatientsPageRoute {
  const PatientsPageRoute();
  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientsPage();
  }
}

@TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path)
class PatientPageRoute extends GoRouteData with $PatientPageRoute {
  const PatientPageRoute(this.id, {this.page = 0});
  static const path = '/patients/:id';

  final String id;
  final int page;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPage(id, page: page);
  }
}

@TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path)
class PatientFormPageRoute extends GoRouteData with $PatientFormPageRoute {
  const PatientFormPageRoute({this.id});
  static const path = '/patients/form';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientFormPage(id: id);
  }
}

// =============================================================================
// Patient Records Routes
// =============================================================================

@TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path)
class PatientRecordPageRoute extends GoRouteData with $PatientRecordPageRoute {
  const PatientRecordPageRoute(this.id);
  static const path = '/patients/records/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordPage(id);
  }
}

@TypedGoRoute<PatientRecordFormPageRoute>(path: PatientRecordFormPageRoute.path)
class PatientRecordFormPageRoute extends GoRouteData
    with $PatientRecordFormPageRoute {
  const PatientRecordFormPageRoute({required this.parentId, this.id});
  static const path = '/patients/records/form';

  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientRecordFormPage(parentId: parentId, id: id);
  }
}

// =============================================================================
// Patient Treatment Records Routes
// =============================================================================

@TypedGoRoute<PatientTreatmentsRecordPageRoute>(
    path: PatientTreatmentsRecordPageRoute.path)
class PatientTreatmentsRecordPageRoute extends GoRouteData
    with $PatientTreatmentsRecordPageRoute {
  const PatientTreatmentsRecordPageRoute(this.id);
  static const path = '/patients/treatment-records';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordsPage(id: id);
  }
}

@TypedGoRoute<PatientTreatmentRecordPageRoute>(
    path: PatientTreatmentRecordPageRoute.path)
class PatientTreatmentRecordPageRoute extends GoRouteData
    with $PatientTreatmentRecordPageRoute {
  const PatientTreatmentRecordPageRoute(this.id);
  static const path = '/patients/treatment-records/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordPage(id);
  }
}

@TypedGoRoute<PatientTreatmentRecordFormPageRoute>(
    path: PatientTreatmentRecordFormPageRoute.path)
class PatientTreatmentRecordFormPageRoute extends GoRouteData
    with $PatientTreatmentRecordFormPageRoute {
  const PatientTreatmentRecordFormPageRoute({required this.parentId, this.id});
  static const path = '/patients/treatment-records/form';

  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientTreatmentRecordFormPage(parentId: parentId, id: id);
  }
}

// =============================================================================
// Patient Prescription Item Routes
// =============================================================================

@TypedGoRoute<PatientPrescriptionItemFormPageRoute>(
    path: PatientPrescriptionItemFormPageRoute.path)
class PatientPrescriptionItemFormPageRoute extends GoRouteData
    with $PatientPrescriptionItemFormPageRoute {
  const PatientPrescriptionItemFormPageRoute({required this.parentId, this.id});
  static const path = '/patients/prescriptions/form';

  final String parentId;
  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPrescriptionItemFormPage(
      parentId: parentId,
      id: id,
    );
  }
}

// =============================================================================
// Patient Files Routes
// =============================================================================

@TypedGoRoute<PatientFileFormPageRoute>(path: PatientFileFormPageRoute.path)
class PatientFileFormPageRoute extends GoRouteData
    with $PatientFileFormPageRoute {
  const PatientFileFormPageRoute({required this.parentId, this.id});
  static const path = '/patients/files/form';

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
