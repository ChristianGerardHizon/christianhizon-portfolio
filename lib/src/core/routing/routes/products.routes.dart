part of '../main.routes.dart';

class ProductsBranchData extends StatefulShellBranchData {
  const ProductsBranchData();
}

@TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path)
class ProductsPageRoute extends GoRouteData {
  const ProductsPageRoute();
  static const path = '/products';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductsPage();
  }
}

@TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path)
class ProductFormPageRoute extends GoRouteData {
  const ProductFormPageRoute({this.id});
  static const path = '/form/product';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductFormPage(id: id);
  }
}

@TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path)
class ProductPageRoute extends GoRouteData {
  const ProductPageRoute(this.id);
  static const path = '/product/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductPage(id);
  }
}
