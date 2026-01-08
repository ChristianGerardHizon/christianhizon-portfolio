part of '../main.routes.dart';

class AppointmentSchedulesData extends StatefulShellBranchData {
  const AppointmentSchedulesData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<AppointmentSchedulesPageRoute>(
        path: AppointmentSchedulesPageRoute.path),
    TypedGoRoute<AppointmentSchedulesByDatePageRoute>(
        path: AppointmentSchedulesByDatePageRoute.path),
    TypedGoRoute<AppointmentSchedulePageRoute>(
        path: AppointmentSchedulePageRoute.path),
    TypedGoRoute<AppointmentScheduleFormPageRoute>(
        path: AppointmentScheduleFormPageRoute.path),
  ];
}

@TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
    path: PatientAppointmentSchedulesPageRoute.path)
class PatientAppointmentSchedulesPageRoute extends GoRouteData with $PatientAppointmentSchedulesPageRoute {
  const PatientAppointmentSchedulesPageRoute();
  static const path = '/patient/appointmentSchedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}

@TypedGoRoute<AppointmentSchedulesPageRoute>(
    path: AppointmentSchedulesPageRoute.path)
class AppointmentSchedulesPageRoute extends GoRouteData with $AppointmentSchedulesPageRoute {
  const AppointmentSchedulesPageRoute();
  static const path = '/appointmentSchedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}

@TypedGoRoute<AppointmentSchedulesByDatePageRoute>(
    path: AppointmentSchedulesByDatePageRoute.path)
class AppointmentSchedulesByDatePageRoute extends GoRouteData with $AppointmentSchedulesByDatePageRoute {
  const AppointmentSchedulesByDatePageRoute({this.date});
  static const path = '/today/appointmentSchedules';

  final DateTime? date;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentSchedulesByDatePage(
      date: date,
    );
  }
}

@TypedGoRoute<AppointmentScheduleFormPageRoute>(
    path: AppointmentScheduleFormPageRoute.path)
class AppointmentScheduleFormPageRoute extends GoRouteData with $AppointmentScheduleFormPageRoute {
  const AppointmentScheduleFormPageRoute({
    this.id,
    this.patientId,
    this.patientRecordId,
  });
  static const path = '/form/appointmentSchedule';

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

@TypedGoRoute<AppointmentSchedulePageRoute>(
    path: AppointmentSchedulePageRoute.path)
class AppointmentSchedulePageRoute extends GoRouteData with $AppointmentSchedulePageRoute {
  const AppointmentSchedulePageRoute(this.id);
  static const path = '/appointmentSchedule/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AppointmentSchedulePage(id);
  }
}

class CalendarAppointmentSchedulesData extends StatefulShellBranchData {
  const CalendarAppointmentSchedulesData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
        path: CalendarAppointmentSchedulesPageRoute.path),
  ];
}

@TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
    path: CalendarAppointmentSchedulesPageRoute.path)
class CalendarAppointmentSchedulesPageRoute extends GoRouteData with $CalendarAppointmentSchedulesPageRoute {
  const CalendarAppointmentSchedulesPageRoute();
  static const path = '/calendar';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentScheduleCalendarPage();
  }
}
