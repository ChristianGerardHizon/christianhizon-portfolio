part of '../main.routes.dart';

class PatientsBranchData extends StatefulShellBranchData {
  const PatientsBranchData();

  static const routes = <TypeRouteData>[
        ///
        /// Patient
        ///
        TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path),
        TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path),
        TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path),

        ///
        /// Patient Record
        ///
        TypedGoRoute<PatientRecordPageRoute>(path: PatientRecordPageRoute.path),
        TypedGoRoute<PatientRecordFormPageRoute>(
            path: PatientRecordFormPageRoute.path),

        ///
        /// Categories
        ///
        TypedGoRoute<ProductCategoriesPageRoute>(
            path: ProductCategoriesPageRoute.path),
        TypedGoRoute<ProductCategoryPageRoute>(
            path: ProductCategoryPageRoute.path),
        TypedGoRoute<ProductCategoryFormPageRoute>(
            path: ProductCategoryFormPageRoute.path),

        ///
        /// Patient Treatment Records
        ///
        TypedGoRoute<PatientTreatmentsRecordPageRoute>(
            path: PatientTreatmentsRecordPageRoute.path),
        TypedGoRoute<PatientTreatmentRecordPageRoute>(
            path: PatientTreatmentRecordPageRoute.path),
        TypedGoRoute<PatientTreatmentRecordFormPageRoute>(
            path: PatientTreatmentRecordFormPageRoute.path),

        ///
        /// Patient Prescription Item
        ///
        TypedGoRoute<PatientPrescriptionItemFormPageRoute>(
            path: PatientPrescriptionItemFormPageRoute.path),

        ///
        /// Appointments
        ///
        TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
            path: PatientAppointmentSchedulesPageRoute.path),

        ///
        /// Files
        ///
        TypedGoRoute<PatientFileFormPageRoute>(
            path: PatientFileFormPageRoute.path),
      ];
}

@TypedGoRoute<PatientsPageRoute>(path: PatientsPageRoute.path)
class PatientsPageRoute extends GoRouteData {
  const PatientsPageRoute();
  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientsPage();
  }
}

@TypedGoRoute<PatientPageRoute>(path: PatientPageRoute.path)
class PatientPageRoute extends GoRouteData {
  const PatientPageRoute(this.id, {this.page = 0});
  static const path = '/patient/:id';

  final String id;
  final int page;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientPage(id, page: 0);
  }
}

@TypedGoRoute<PatientFormPageRoute>(path: PatientFormPageRoute.path)
class PatientFormPageRoute extends GoRouteData {
  const PatientFormPageRoute({this.id});
  static const path = '/form/patient';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PatientFormPage(id: id);
  }
}
