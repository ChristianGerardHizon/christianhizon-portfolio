// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appointmentsRoute,
    ];

RouteBase get $appointmentsRoute => GoRouteData.$route(
      path: '/appointments',
      factory: $AppointmentsRoute._fromState,
    );

mixin $AppointmentsRoute on GoRouteData {
  static AppointmentsRoute _fromState(GoRouterState state) =>
      const AppointmentsRoute();

  @override
  String get location => GoRouteData.$location(
        '/appointments',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
