part of '../main.routes.dart';

class AppointmentSchedulesData extends StatefulShellBranchData {
  const AppointmentSchedulesData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<AppointmentSchedulesPageRoute>(
        path: AppointmentSchedulesPageRoute.path),
    TypedGoRoute<AppointmentSchedulesTodayPageRoute>(
        path: AppointmentSchedulesTodayPageRoute.path),
    TypedGoRoute<AppointmentSchedulePageRoute>(
        path: AppointmentSchedulePageRoute.path),
    TypedGoRoute<AppointmentScheduleFormPageRoute>(
        path: AppointmentScheduleFormPageRoute.path),
  ];
}

@TypedGoRoute<PatientAppointmentSchedulesPageRoute>(
    path: PatientAppointmentSchedulesPageRoute.path)
class PatientAppointmentSchedulesPageRoute extends GoRouteData {
  const PatientAppointmentSchedulesPageRoute();
  static const path = '/patient/appointmentSchedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}

@TypedGoRoute<AppointmentSchedulesPageRoute>(
    path: AppointmentSchedulesPageRoute.path)
class AppointmentSchedulesPageRoute extends GoRouteData {
  const AppointmentSchedulesPageRoute();
  static const path = '/appointmentSchedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesPage();
  }
}

@TypedGoRoute<AppointmentSchedulesTodayPageRoute>(
    path: AppointmentSchedulesTodayPageRoute.path)
class AppointmentSchedulesTodayPageRoute extends GoRouteData {
  const AppointmentSchedulesTodayPageRoute();
  static const path = '/today/appointmentSchedules';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentSchedulesTodayPage();
  }
}

@TypedGoRoute<AppointmentScheduleFormPageRoute>(
    path: AppointmentScheduleFormPageRoute.path)
class AppointmentScheduleFormPageRoute extends GoRouteData {
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
class AppointmentSchedulePageRoute extends GoRouteData {
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
}

@TypedGoRoute<CalendarAppointmentSchedulesPageRoute>(
    path: CalendarAppointmentSchedulesPageRoute.path)
class CalendarAppointmentSchedulesPageRoute extends GoRouteData {
  const CalendarAppointmentSchedulesPageRoute();
  static const path = '/calendar';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppointmentScheduleCalendarPage();
  }
}
