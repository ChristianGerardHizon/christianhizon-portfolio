// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $systemShellRoute,
    ];

RouteBase get $systemShellRoute => ShellRouteData.$route(
      factory: $SystemShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/system',
          factory: $SystemRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'branches',
              factory: $BranchesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $BranchDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'species',
              factory: $SpeciesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $SpeciesDetailRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'product-categories',
              factory: $ProductCategoriesRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':id',
                  factory: $ProductCategoryDetailRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $SystemShellRouteExtension on SystemShellRoute {
  static SystemShellRoute _fromState(GoRouterState state) =>
      const SystemShellRoute();
}

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

mixin $BranchDetailRoute on GoRouteData {
  static BranchDetailRoute _fromState(GoRouterState state) => BranchDetailRoute(
        id: state.pathParameters['id']!,
      );

  BranchDetailRoute get _self => this as BranchDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/branches/${Uri.encodeComponent(_self.id)}',
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

mixin $SpeciesDetailRoute on GoRouteData {
  static SpeciesDetailRoute _fromState(GoRouterState state) =>
      SpeciesDetailRoute(
        id: state.pathParameters['id']!,
      );

  SpeciesDetailRoute get _self => this as SpeciesDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/species/${Uri.encodeComponent(_self.id)}',
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

mixin $ProductCategoryDetailRoute on GoRouteData {
  static ProductCategoryDetailRoute _fromState(GoRouterState state) =>
      ProductCategoryDetailRoute(
        id: state.pathParameters['id']!,
      );

  ProductCategoryDetailRoute get _self => this as ProductCategoryDetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/system/product-categories/${Uri.encodeComponent(_self.id)}',
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
