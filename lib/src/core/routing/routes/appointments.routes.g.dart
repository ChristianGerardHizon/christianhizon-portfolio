// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointments.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appointmentsShellRoute,
    ];

RouteBase get $appointmentsShellRoute => ShellRouteData.$route(
      factory: $AppointmentsShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/appointments',
          factory: $AppointmentsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':id',
              factory: $AppointmentDetailRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $AppointmentsShellRouteExtension on AppointmentsShellRoute {
  static AppointmentsShellRoute _fromState(GoRouterState state) =>
      const AppointmentsShellRoute();
}

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

mixin $AppointmentDetailRoute on GoRouteData {
  static AppointmentDetailRoute _fromState(GoRouterState state) =>
      AppointmentDetailRoute(
        id: state.pathParameters['id']!,
      );

  AppointmentDetailRoute get _self => this as AppointmentDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/appointments/${Uri.encodeComponent(_self.id)}',
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
