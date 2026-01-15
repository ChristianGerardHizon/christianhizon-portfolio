import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/appointments/presentation/pages/appointment_detail_page.dart';
import '../../../features/appointments/presentation/pages/appointments_list_page.dart';
import '../../../features/appointments/presentation/pages/appointments_shell.dart';
import '../../utils/breakpoints.dart';

part 'appointments.routes.g.dart';

/// Appointments shell route for master-detail layout.
///
/// On tablet: Shows list and detail side-by-side
/// On mobile: Shows list, then navigates to detail
@TypedShellRoute<AppointmentsShellRoute>(
  routes: [
    TypedGoRoute<AppointmentsRoute>(
      path: AppointmentsRoute.path,
      routes: [
        TypedGoRoute<AppointmentDetailRoute>(path: ':id'),
      ],
    ),
  ],
)
class AppointmentsShellRoute extends ShellRouteData {
  const AppointmentsShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AppointmentsShell(child: navigator);
  }
}

/// Appointments list page route.
class AppointmentsRoute extends GoRouteData with $AppointmentsRoute {
  const AppointmentsRoute();

  static const path = '/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // On tablet, this is handled by the shell - return empty container
    // On mobile, this shows the list page
    if (Breakpoints.isTabletOrLarger(context)) {
      return const SizedBox.shrink();
    }
    return const AppointmentsListPage();
  }
}

/// Appointment detail page route.
class AppointmentDetailRoute extends GoRouteData with $AppointmentDetailRoute {
  const AppointmentDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentDetailPage(appointmentId: id);
  }
}
