import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_adjustment_repository.dart';
import '../../domain/product_adjustment.dart';

part 'product_adjustments_controller.g.dart';

/// Provider for product adjustments by product ID.
@riverpod
Future<List<ProductAdjustment>> productAdjustments(
    Ref ref, String productId) async {
  final repository = ref.read(productAdjustmentRepositoryProvider);
  final result = await repository.fetchByProduct(productId);

  return result.fold(
    (failure) => [],
    (adjustments) => adjustments,
  );
}

/// Controller for managing product adjustments list.
@riverpod
class ProductAdjustmentsController extends _$ProductAdjustmentsController {
  @override
  FutureOr<List<ProductAdjustment>> build(String productId) async {
    final repository = ref.read(productAdjustmentRepositoryProvider);
    final result = await repository.fetchByProduct(productId);

    return result.fold(
      (failure) => [],
      (adjustments) => adjustments,
    );
  }

  /// Refreshes the adjustments list.
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repository = ref.read(productAdjustmentRepositoryProvider);
    final result = await repository.fetchByProduct(productId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (adjustments) => AsyncData(adjustments),
    );
  }
}
