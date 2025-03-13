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

@TypedGoRoute<ProductCreatePageRoute>(path: ProductCreatePageRoute.path)
class ProductCreatePageRoute extends GoRouteData {
  const ProductCreatePageRoute();
  static const path = '/product/create';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductCreatePage();
  }
}

@TypedGoRoute<ProductUpdatePageRoute>(path: ProductUpdatePageRoute.path)
class ProductUpdatePageRoute extends GoRouteData {
  const ProductUpdatePageRoute(this.id);
  static const path = '/product/update/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductUpdatePage(id);
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
