import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/patients/domain/patient_tab.dart';
import '../../../features/patients/presentation/pages/patient_detail_page.dart';
import '../../../features/patients/presentation/pages/patients_list_page.dart';
import '../../../features/patients/presentation/pages/patients_shell.dart';
import '../../../features/patients/presentation/pages/record_detail_page.dart';
import '../../utils/breakpoints.dart';

part 'patients.routes.g.dart';

/// Patients shell route for master-detail layout.
///
/// On tablet: Shows list and detail side-by-side
/// On mobile: Shows list, then navigates to detail
@TypedShellRoute<PatientsShellRoute>(
  routes: [
    TypedGoRoute<PatientsRoute>(
      path: PatientsRoute.path,
      routes: [
        TypedGoRoute<PatientDetailRoute>(
          path: ':id',
          routes: [
            TypedGoRoute<RecordDetailRoute>(path: 'records/:recordId'),
          ],
        ),
      ],
    ),
  ],
)
class PatientsShellRoute extends ShellRouteData {
  const PatientsShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return PatientsShell(child: navigator);
  }
}

/// Patients list page route.
class PatientsRoute extends GoRouteData with $PatientsRoute {
  const PatientsRoute();

  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const PatientsListPage();
  }
}

/// Patient detail page route.
class PatientDetailRoute extends GoRouteData with $PatientDetailRoute {
  const PatientDetailRoute({required this.id, this.tab});

  final String id;
  final String? tab;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final tabName = state.uri.queryParameters['tab'];
    return PatientDetailPage(
      patientId: id,
      initialTab: PatientTab.fromString(tabName),
    );
  }
}

/// Record detail page route.
///
/// Use recordId='new' to create a new record.
class RecordDetailRoute extends GoRouteData with $RecordDetailRoute {
  const RecordDetailRoute({required this.id, required this.recordId});

  final String id;
  final String recordId;

  /// Check if this is a new record creation route.
  bool get isNewRecord => recordId == 'new';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RecordDetailPage(
      patientId: id,
      recordId: isNewRecord ? null : recordId,
    );
  }
}
