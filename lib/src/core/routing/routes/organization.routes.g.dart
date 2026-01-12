// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $organizationRoute,
    ];

RouteBase get $organizationRoute => GoRouteData.$route(
      path: '/organization',
      factory: $OrganizationRoute._fromState,
    );

mixin $OrganizationRoute on GoRouteData {
  static OrganizationRoute _fromState(GoRouterState state) =>
      const OrganizationRoute();

  @override
  String get location => GoRouteData.$location(
        '/organization',
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
