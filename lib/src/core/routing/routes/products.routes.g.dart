// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $productsRoute,
    ];

RouteBase get $productsRoute => GoRouteData.$route(
      path: '/products',
      factory: $ProductsRoute._fromState,
    );

mixin $ProductsRoute on GoRouteData {
  static ProductsRoute _fromState(GoRouterState state) => const ProductsRoute();

  @override
  String get location => GoRouteData.$location(
        '/products',
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
