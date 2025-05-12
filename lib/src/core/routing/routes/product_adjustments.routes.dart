part of '../main.routes.dart';

class ProductAdjustmentsBranchData extends StatefulShellBranchData {
  const ProductAdjustmentsBranchData();

  static const routes = <TypeRouteData>[
    TypedGoRoute<ProductAdjustmentFormPageRoute>(
        path: ProductAdjustmentFormPageRoute.path),
  ];
}

@TypedGoRoute<ProductAdjustmentFormPageRoute>(
    path: ProductAdjustmentFormPageRoute.path)
class ProductAdjustmentFormPageRoute extends GoRouteData {
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
