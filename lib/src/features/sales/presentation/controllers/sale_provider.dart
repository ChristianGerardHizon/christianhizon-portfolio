import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../pos/data/repositories/sales_repository.dart';
import '../../../pos/domain/sale.dart';

part 'sale_provider.g.dart';

/// Provider for fetching a single sale by ID.
@riverpod
Future<Sale?> sale(Ref ref, String id) async {
  final repository = ref.watch(salesRepositoryProvider);
  final result = await repository.getSale(id);
  return result.fold((f) => null, (sale) => sale);
}
