import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/patients/domain/patient_tab.dart';
import '../../../features/patients/presentation/pages/patient_detail_page.dart';
import '../../../features/patients/presentation/pages/patients_shell.dart';
import '../../../features/patients/presentation/pages/record_detail_page.dart';

part 'patients.routes.g.dart';

/// Patients list page route.
@TypedGoRoute<PatientsRoute>(
  path: PatientsRoute.path,
  routes: [
    TypedGoRoute<PatientDetailRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<RecordDetailRoute>(path: 'records/:recordId'),
      ],
    ),
  ],
)
class PatientsRoute extends GoRouteData with $PatientsRoute {
  const PatientsRoute();

  static const path = '/patients';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientsShell();
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
class RecordDetailRoute extends GoRouteData with $RecordDetailRoute {
  const RecordDetailRoute({required this.id, required this.recordId});

  final String id;
  final String recordId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RecordDetailPage(
      patientId: id,
      recordId: recordId,
    );
  }
}
