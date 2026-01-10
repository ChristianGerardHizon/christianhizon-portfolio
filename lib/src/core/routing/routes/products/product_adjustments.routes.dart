part of '../../main.routes.dart';

class ProductAdjustmentsBranchData extends StatefulShellBranchData {
  const ProductAdjustmentsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<ProductAdjustmentsPageRoute>(
        path: ProductAdjustmentsPageRoute.path),
    TypedGoRoute<ProductAdjustmentFormPageRoute>(
        path: ProductAdjustmentFormPageRoute.path),
  ];
}

@TypedGoRoute<ProductAdjustmentsPageRoute>(
    path: ProductAdjustmentsPageRoute.path)
class ProductAdjustmentsPageRoute extends GoRouteData with $ProductAdjustmentsPageRoute {
  const ProductAdjustmentsPageRoute({this.productId, this.productStockId});
  static const path = '/product-adjustments';

  final String? productId;
  final String? productStockId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductAdjustmentsPage(
      productId: productId,
      productStockId: productStockId,
    );
  }
}

@TypedGoRoute<ProductAdjustmentFormPageRoute>(
    path: ProductAdjustmentFormPageRoute.path)
class ProductAdjustmentFormPageRoute extends GoRouteData with $ProductAdjustmentFormPageRoute {
  const ProductAdjustmentFormPageRoute(
      {this.id, this.productId, this.productStockId});
  static const path = '/form/product-adjustments';

  final String? id;
  final String? productId;
  final String? productStockId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductAdjustmentFormPage(
        id: id, productId: productId, productStockId: productStockId);
  }
}
