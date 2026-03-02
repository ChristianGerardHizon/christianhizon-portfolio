// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $portfolioRoute,
      $allProjectsRoute,
      $techStackRoute,
      $workHistoryRoute,
      $projectDetailRoute,
    ];

RouteBase get $portfolioRoute => GoRouteData.$route(
      path: '/',
      factory: $PortfolioRoute._fromState,
    );

mixin $PortfolioRoute on GoRouteData {
  static PortfolioRoute _fromState(GoRouterState state) =>
      const PortfolioRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
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

RouteBase get $allProjectsRoute => GoRouteData.$route(
      path: '/projects',
      factory: $AllProjectsRoute._fromState,
    );

mixin $AllProjectsRoute on GoRouteData {
  static AllProjectsRoute _fromState(GoRouterState state) =>
      const AllProjectsRoute();

  @override
  String get location => GoRouteData.$location(
        '/projects',
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

RouteBase get $techStackRoute => GoRouteData.$route(
      path: '/tech-stack',
      factory: $TechStackRoute._fromState,
    );

mixin $TechStackRoute on GoRouteData {
  static TechStackRoute _fromState(GoRouterState state) =>
      const TechStackRoute();

  @override
  String get location => GoRouteData.$location(
        '/tech-stack',
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

RouteBase get $workHistoryRoute => GoRouteData.$route(
      path: '/work-history',
      factory: $WorkHistoryRoute._fromState,
    );

mixin $WorkHistoryRoute on GoRouteData {
  static WorkHistoryRoute _fromState(GoRouterState state) =>
      const WorkHistoryRoute();

  @override
  String get location => GoRouteData.$location(
        '/work-history',
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

RouteBase get $projectDetailRoute => GoRouteData.$route(
      path: '/projects/:id',
      factory: $ProjectDetailRoute._fromState,
    );

mixin $ProjectDetailRoute on GoRouteData {
  static ProjectDetailRoute _fromState(GoRouterState state) =>
      ProjectDetailRoute(
        id: state.pathParameters['id']!,
      );

  ProjectDetailRoute get _self => this as ProjectDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/projects/${Uri.encodeComponent(_self.id)}',
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
