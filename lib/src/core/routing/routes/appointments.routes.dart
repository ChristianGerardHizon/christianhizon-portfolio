import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/appointments/presentation/pages/appointments_page.dart';

part 'appointments.routes.g.dart';

/// Appointments page route.
@TypedGoRoute<AppointmentsRoute>(path: AppointmentsRoute.path)
class AppointmentsRoute extends GoRouteData with $AppointmentsRoute {
  const AppointmentsRoute();

  static const path = '/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentsPage();
  }
}
