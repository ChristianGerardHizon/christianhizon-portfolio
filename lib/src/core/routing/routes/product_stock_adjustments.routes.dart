part of '../main.routes.dart';

class ProductStockAdjustmentsBranchData extends StatefulShellBranchData {
  const ProductStockAdjustmentsBranchData();
}

@TypedGoRoute<ProductStockAdjustmentsFormPageRoute>(
    path: ProductStockAdjustmentsFormPageRoute.path)
class ProductStockAdjustmentsFormPageRoute extends GoRouteData {
  const ProductStockAdjustmentsFormPageRoute(
      {this.id, this.productId, this.productStockId});
  static const path = '/form/product-stock-adjustments';

  final String? id;
  final String? productId;
  final String? productStockId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProductStockAdjustmentFormPage(
        id: id, productId: productId, productStockId: productStockId);
  }
}
