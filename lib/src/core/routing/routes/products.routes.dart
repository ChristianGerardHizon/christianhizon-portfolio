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

@TypedGoRoute<ProductInventoriesPageRoute>(
    path: ProductInventoriesPageRoute.path)
class ProductInventoriesPageRoute extends GoRouteData {
  const ProductInventoriesPageRoute();
  static const path = '/productInventories';

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

@TypedGoRoute<ProductStockFormPageRoute>(path: ProductStockFormPageRoute.path)
class ProductStockFormPageRoute extends GoRouteData {
  const ProductStockFormPageRoute({this.id, required this.productId});
  static const path = '/form/productStock';

  final String? id;
  final String productId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockFormPage(
      id: id,
      productId: productId,
    );
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

@TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path)
class ProductStockPageRoute extends GoRouteData {
  const ProductStockPageRoute(this.id);
  static const path = '/product/form/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockPage(id);
  }
}
