part of '../main.routes.dart';

class ProductsBranchData extends StatefulShellBranchData {
  const ProductsBranchData();

  static const routes = <TypeRouteData>[
        ///
        /// Products
        ///
        TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path),
        TypedGoRoute<ProductPageRoute>(path: ProductPageRoute.path),
        TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path),

        ///
        /// Inventory
        ///
        TypedGoRoute<ProductInventoriesPageRoute>(
            path: ProductInventoriesPageRoute.path),

        ///
        /// Stocks
        ///
        TypedGoRoute<ProductStockFormPageRoute>(
            path: ProductStockFormPageRoute.path),
        TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path),
      ];
}

@TypedGoRoute<ProductsPageRoute>(path: ProductsPageRoute.path)
class ProductsPageRoute extends GoRouteData with $ProductsPageRoute {
  const ProductsPageRoute();
  static const path = '/products';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductsPage();
  }
}

@TypedGoRoute<ProductInventoriesPageRoute>(
    path: ProductInventoriesPageRoute.path)
class ProductInventoriesPageRoute extends GoRouteData with $ProductInventoriesPageRoute {
  const ProductInventoriesPageRoute();
  static const path = '/productInventories';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProductInventoriesPage();
  }
}

@TypedGoRoute<ProductFormPageRoute>(path: ProductFormPageRoute.path)
class ProductFormPageRoute extends GoRouteData with $ProductFormPageRoute {
  const ProductFormPageRoute({this.id});
  static const path = '/form/product';

  final String? id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductFormPage(id: id);
  }
}

@TypedGoRoute<ProductStockFormPageRoute>(path: ProductStockFormPageRoute.path)
class ProductStockFormPageRoute extends GoRouteData with $ProductStockFormPageRoute {
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
class ProductPageRoute extends GoRouteData with $ProductPageRoute {
  const ProductPageRoute(this.id);
  static const path = '/product/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductPage(id);
  }
}

// @TypedGoRoute<ProductAddStockFormPageRoute>(
//     path: ProductAddStockFormPageRoute.path)
// class ProductAddStockFormPageRoute extends GoRouteData with $ProductAddStockFormPageRoute {
//   const ProductAddStockFormPageRoute(this.id);
//   static const path = '/product/simple/add';

//   final String id;

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return ProductAddStockFormPage(id);
//   }
// }

@TypedGoRoute<ProductStockPageRoute>(path: ProductStockPageRoute.path)
class ProductStockPageRoute extends GoRouteData with $ProductStockPageRoute {
  const ProductStockPageRoute(this.id);
  static const path = '/product/form/:id';

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockPage(id);
  }
}
