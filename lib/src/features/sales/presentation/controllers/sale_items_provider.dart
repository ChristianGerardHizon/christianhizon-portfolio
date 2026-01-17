import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../pos/data/repositories/sales_repository.dart';
import '../../../pos/domain/sale_item.dart';

part 'sale_items_provider.g.dart';

/// Provider for fetching sale items by sale ID.
@riverpod
Future<List<SaleItem>> saleItems(Ref ref, String saleId) async {
  final repository = ref.watch(salesRepositoryProvider);
  final result = await repository.getSaleItems(saleId);
  return result.fold((f) => [], (items) => items);
}
