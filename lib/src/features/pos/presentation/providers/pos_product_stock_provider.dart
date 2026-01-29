import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../products/domain/product.dart';
import '../../../products/domain/product_status.dart';
import '../../../products/presentation/controllers/product_lots_controller.dart';

part 'pos_product_stock_provider.g.dart';

/// Provider that calculates stock status for a product.
///
/// Handles both lot-tracked and non-lot-tracked products.
/// For lot-tracked products, sums all lot quantities to determine stock status.
@riverpod
Future<ProductStatus> posProductStock(Ref ref, Product product) async {
  if (!product.trackStock) return ProductStatus.noThreshold;

  if (!product.trackByLot) {
    return product.stockStatus;
  }

  // For lot-tracked products, calculate from lots
  final total = await ref.watch(productLotsTotalProvider(product.id).future);

  if (total <= 0) return ProductStatus.outOfStock;
  if (product.stockThreshold != null && total <= product.stockThreshold!) {
    return ProductStatus.lowStock;
  }
  return ProductStatus.inStock;
}
