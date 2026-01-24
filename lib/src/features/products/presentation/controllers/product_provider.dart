import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_lot_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/product.dart';

part 'product_provider.g.dart';

/// Provider for a single product by ID.
///
/// For lot-tracked products, this will automatically sync the product's
/// quantity from its lots to ensure the stock status is accurate.
@riverpod
Future<Product?> product(Ref ref, String id) async {
  final repository = ref.read(productRepositoryProvider);
  final result = await repository.fetchOne(id);

  final product = result.fold(
    (failure) => null,
    (product) => product,
  );

  if (product == null) return null;

  // For lot-tracked products, sync quantity from lots
  if (product.trackByLot) {
    final lotRepo = ref.read(productLotRepositoryProvider);
    final totalResult = await lotRepo.calculateTotalQuantity(product.id);

    final total = totalResult.fold(
      (failure) => null,
      (total) => total,
    );

    if (total != null && product.quantity != total) {
      // Update the product's quantity in the database
      final updateResult = await repository.updateQuantity(product.id, total);
      return updateResult.fold(
        // If update fails, still return product with corrected quantity locally
        (failure) => product.copyWith(quantity: total),
        (updated) => updated,
      );
    }
  }

  return product;
}
