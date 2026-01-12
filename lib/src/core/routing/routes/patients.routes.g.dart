// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $patientsRoute,
    ];

RouteBase get $patientsRoute => GoRouteData.$route(
      path: '/patients',
      factory: $PatientsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $PatientDetailRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'records/:recordId',
              factory: $RecordDetailRoute._fromState,
            ),
          ],
        ),
      ],
    );

mixin $PatientsRoute on GoRouteData {
  static PatientsRoute _fromState(GoRouterState state) => const PatientsRoute();

  @override
  String get location => GoRouteData.$location(
        '/patients',
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

mixin $PatientDetailRoute on GoRouteData {
  static PatientDetailRoute _fromState(GoRouterState state) =>
      PatientDetailRoute(
        id: state.pathParameters['id']!,
        tab: state.uri.queryParameters['tab'],
      );

  PatientDetailRoute get _self => this as PatientDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/patients/${Uri.encodeComponent(_self.id)}',
        queryParams: {
          if (_self.tab != null) 'tab': _self.tab,
        },
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

mixin $RecordDetailRoute on GoRouteData {
  static RecordDetailRoute _fromState(GoRouterState state) => RecordDetailRoute(
        id: state.pathParameters['id']!,
        recordId: state.pathParameters['recordId']!,
      );

  RecordDetailRoute get _self => this as RecordDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/patients/${Uri.encodeComponent(_self.id)}/records/${Uri.encodeComponent(_self.recordId)}',
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
