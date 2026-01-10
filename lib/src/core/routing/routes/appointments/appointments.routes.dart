part of '../../main.routes.dart';

/// Appointments Branch - consolidates schedules and calendar views
class AppointmentsBranchData extends StatefulShellBranchData {
  const AppointmentsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<AppointmentSchedulesPageRoute>(
        path: AppointmentSchedulesPageRoute.path),
    TypedGoRoute<AppointmentSchedulesByDatePageRoute>(
        path: AppointmentSchedulesByDatePageRoute.path),
    TypedGoRoute<AppointmentSchedulePageRoute>(
        path: AppointmentSchedulePageRoute.path),
    TypedGoRoute<AppointmentScheduleFormPageRoute>(
        path: AppointmentScheduleFormPageRoute.path),
    TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
        path: CalendarAppointmentSchedulesPageRoute.path),
    TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
        path: PatientAppointmentSchedulesPageRoute.path),
  ];
}

// =============================================================================
// Appointment Schedules Routes
// =============================================================================

@TypedGoRoute<AppointmentSchedulesPageRoute>(
    path: AppointmentSchedulesPageRoute.path)
class AppointmentSchedulesPageRoute extends GoRouteData
    with $AppointmentSchedulesPageRoute {
  const AppointmentSchedulesPageRoute();
  static const path = '/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}

@TypedGoRoute<AppointmentSchedulesByDatePageRoute>(
    path: AppointmentSchedulesByDatePageRoute.path)
class AppointmentSchedulesByDatePageRoute extends GoRouteData
    with $AppointmentSchedulesByDatePageRoute {
  const AppointmentSchedulesByDatePageRoute({this.date});
  static const path = '/appointments/by-date';

  final DateTime? date;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentSchedulesByDatePage(
      date: date,
    );
  }
}

@TypedGoRoute<AppointmentSchedulePageRoute>(
    path: AppointmentSchedulePageRoute.path)
class AppointmentSchedulePageRoute extends GoRouteData
    with $AppointmentSchedulePageRoute {
  const AppointmentSchedulePageRoute(this.id);
  static const path = '/appointments/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentSchedulePage(id);
  }
}

@TypedGoRoute<AppointmentScheduleFormPageRoute>(
    path: AppointmentScheduleFormPageRoute.path)
class AppointmentScheduleFormPageRoute extends GoRouteData
    with $AppointmentScheduleFormPageRoute {
  const AppointmentScheduleFormPageRoute({
    this.id,
    this.patientId,
    this.patientRecordId,
  });
  static const path = '/appointments/form';

  final String? id;
  final String? patientId;
  final String? patientRecordId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentScheduleFormPage(
      id: id,
      patientId: patientId,
      patientRecordId: patientRecordId,
    );
  }
}

// =============================================================================
// Calendar View Route
// =============================================================================

@TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
    path: CalendarAppointmentSchedulesPageRoute.path)
class CalendarAppointmentSchedulesPageRoute extends GoRouteData
    with $CalendarAppointmentSchedulesPageRoute {
  const CalendarAppointmentSchedulesPageRoute();
  static const path = '/appointments/calendar';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentScheduleCalendarPage();
  }
}

// =============================================================================
// Patient Appointments Route (for viewing patient-specific appointments)
// =============================================================================

@TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
    path: PatientAppointmentSchedulesPageRoute.path)
class PatientAppointmentSchedulesPageRoute extends GoRouteData
    with $PatientAppointmentSchedulesPageRoute {
  const PatientAppointmentSchedulesPageRoute();
  static const path = '/patients/appointments';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}
