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
      routes: [
        GoRouteData.$route(
          path: 'branches',
          factory: $BranchesRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'species',
          factory: $SpeciesRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'breeds',
          factory: $BreedsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'product-categories',
          factory: $ProductCategoriesRoute._fromState,
        ),
      ],
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

mixin $BranchesRoute on GoRouteData {
  static BranchesRoute _fromState(GoRouterState state) => const BranchesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/branches',
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

mixin $SpeciesRoute on GoRouteData {
  static SpeciesRoute _fromState(GoRouterState state) => const SpeciesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/species',
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

mixin $BreedsRoute on GoRouteData {
  static BreedsRoute _fromState(GoRouterState state) => const BreedsRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/breeds',
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

mixin $ProductCategoriesRoute on GoRouteData {
  static ProductCategoriesRoute _fromState(GoRouterState state) =>
      const ProductCategoriesRoute();

  @override
  String get location => GoRouteData.$location(
        '/system/product-categories',
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
