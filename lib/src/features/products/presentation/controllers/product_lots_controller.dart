import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_lot_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/product_lot.dart';
import 'product_provider.dart';

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
      (newLot) async {
        // Prepend new lot to list
        final currentLots = state.value ?? [];
        state = AsyncData([newLot, ...currentLots]);
        // Sync product quantity with total of all lots
        await _syncProductQuantity();
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
      (updatedLot) async {
        // Update lot in list
        final currentLots = state.value ?? [];
        final updatedLots = currentLots.map((l) {
          return l.id == updatedLot.id ? updatedLot : l;
        }).toList();
        state = AsyncData(updatedLots);
        // Sync product quantity with total of all lots
        await _syncProductQuantity();
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
      (_) async {
        // Remove lot from list
        final currentLots = state.value ?? [];
        final filteredLots = currentLots.where((l) => l.id != lotId).toList();
        state = AsyncData(filteredLots);
        // Sync product quantity with total of all lots
        await _syncProductQuantity();
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
      (updatedLot) async {
        // Update lot in list
        final currentLots = state.value ?? [];
        final updatedLots = currentLots.map((l) {
          return l.id == updatedLot.id ? updatedLot : l;
        }).toList();
        state = AsyncData(updatedLots);
        // Sync product quantity with total of all lots
        await _syncProductQuantity();
        return true;
      },
    );
  }

  /// Syncs the parent product's quantity field with the total of all lots.
  Future<void> _syncProductQuantity() async {
    final lotRepo = ref.read(productLotRepositoryProvider);
    final productRepo = ref.read(productRepositoryProvider);

    final totalResult = await lotRepo.calculateTotalQuantity(productId);
    await totalResult.fold(
      (failure) async {},
      (total) async {
        await productRepo.updateQuantity(productId, total);
      },
    );

    // Invalidate providers to refresh UI
    ref.invalidate(productLotsTotalProvider(productId));
    ref.invalidate(productProvider(productId));
  }
}
