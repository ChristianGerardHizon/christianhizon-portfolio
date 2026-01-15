import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_lot_repository.dart';
import '../../domain/product_lot.dart';

part 'product_lots_controller.g.dart';

/// Provider for product lots by product ID.
@riverpod
Future<List<ProductLot>> productLots(Ref ref, String productId) async {
  final repository = ref.read(productLotRepositoryProvider);
  final result = await repository.fetchByProduct(productId);

  return result.fold(
    (failure) => [],
    (lots) => lots,
  );
}

/// Provider for total quantity of lots for a product.
@riverpod
Future<num> productLotsTotal(Ref ref, String productId) async {
  final repository = ref.read(productLotRepositoryProvider);
  final result = await repository.calculateTotalQuantity(productId);

  return result.fold(
    (failure) => 0,
    (total) => total,
  );
}

/// Controller for managing product lots.
@riverpod
class ProductLotsController extends _$ProductLotsController {
  @override
  FutureOr<List<ProductLot>> build(String productId) async {
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.fetchByProduct(productId);

    return result.fold(
      (failure) => [],
      (lots) => lots,
    );
  }

  /// Refreshes the lot list.
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.fetchByProduct(productId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (lots) => AsyncData(lots),
    );
  }

  /// Creates a new lot.
  Future<bool> createLot(ProductLot lot) async {
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.create(lot);

    return result.fold(
      (failure) => false,
      (newLot) {
        // Prepend new lot to list
        final currentLots = state.value ?? [];
        state = AsyncData([newLot, ...currentLots]);
        // Invalidate total quantity
        ref.invalidate(productLotsTotalProvider(productId));
        return true;
      },
    );
  }

  /// Updates an existing lot.
  Future<bool> updateLot(ProductLot lot) async {
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.update(lot);

    return result.fold(
      (failure) => false,
      (updatedLot) {
        // Update lot in list
        final currentLots = state.value ?? [];
        final updatedLots = currentLots.map((l) {
          return l.id == updatedLot.id ? updatedLot : l;
        }).toList();
        state = AsyncData(updatedLots);
        // Invalidate total quantity
        ref.invalidate(productLotsTotalProvider(productId));
        return true;
      },
    );
  }

  /// Deletes a lot.
  Future<bool> deleteLot(String lotId) async {
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.delete(lotId);

    return result.fold(
      (failure) => false,
      (_) {
        // Remove lot from list
        final currentLots = state.value ?? [];
        final filteredLots = currentLots.where((l) => l.id != lotId).toList();
        state = AsyncData(filteredLots);
        // Invalidate total quantity
        ref.invalidate(productLotsTotalProvider(productId));
        return true;
      },
    );
  }

  /// Updates quantity for a lot.
  Future<bool> updateQuantity(String lotId, num quantity) async {
    final repository = ref.read(productLotRepositoryProvider);
    final result = await repository.updateQuantity(lotId, quantity);

    return result.fold(
      (failure) => false,
      (updatedLot) {
        // Update lot in list
        final currentLots = state.value ?? [];
        final updatedLots = currentLots.map((l) {
          return l.id == updatedLot.id ? updatedLot : l;
        }).toList();
        state = AsyncData(updatedLots);
        // Invalidate total quantity
        ref.invalidate(productLotsTotalProvider(productId));
        return true;
      },
    );
  }
}
