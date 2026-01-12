// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $systemRoute,
    ];

RouteBase get $systemRoute => GoRouteData.$route(
      path: '/system',
      factory: $SystemRoute._fromState,
    );

mixin $SystemRoute on GoRouteData {
  static SystemRoute _fromState(GoRouterState state) => const SystemRoute();

  @override
  String get location => GoRouteData.$location(
        '/system',
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
