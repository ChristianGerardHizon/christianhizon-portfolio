// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $adminProfileRoute,
      $adminProjectsShellRoute,
    ];

RouteBase get $adminProfileRoute => GoRouteData.$route(
      path: '/admin/profile',
      factory: $AdminProfileRoute._fromState,
    );

mixin $AdminProfileRoute on GoRouteData {
  static AdminProfileRoute _fromState(GoRouterState state) =>
      const AdminProfileRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/profile',
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

RouteBase get $adminProjectsShellRoute => ShellRouteData.$route(
      factory: $AdminProjectsShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/admin/projects',
          factory: $AdminProjectsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':id',
              factory: $AdminProjectDetailRoute._fromState,
            ),
          ],
        ),
      ],
    );

extension $AdminProjectsShellRouteExtension on AdminProjectsShellRoute {
  static AdminProjectsShellRoute _fromState(GoRouterState state) =>
      const AdminProjectsShellRoute();
}

mixin $AdminProjectsRoute on GoRouteData {
  static AdminProjectsRoute _fromState(GoRouterState state) =>
      const AdminProjectsRoute();

  @override
  String get location => GoRouteData.$location(
        '/admin/projects',
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

mixin $AdminProjectDetailRoute on GoRouteData {
  static AdminProjectDetailRoute _fromState(GoRouterState state) =>
      AdminProjectDetailRoute(
        id: state.pathParameters['id']!,
      );

  AdminProjectDetailRoute get _self => this as AdminProjectDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/admin/projects/${Uri.encodeComponent(_self.id)}',
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
