import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_repository.dart';
import '../../domain/product.dart';

part 'product_provider.g.dart';

/// Provider for a single product by ID.
@riverpod
Future<Product?> product(Ref ref, String id) async {
  final repository = ref.read(productRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (product) => product,
  );
}
