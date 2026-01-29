import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../pos/data/repositories/sales_repository.dart';
import '../../../pos/domain/sale.dart';
import '../../../settings/presentation/controllers/current_branch_controller.dart';

part 'todays_sales_controller.g.dart';

/// Record class for today's sales summary.
class TodaySalesSummary {
  const TodaySalesSummary({
    required this.count,
    required this.total,
  });

  final int count;
  final num total;
}

/// Today's sales data.
/// Filtered by the current branch.
@riverpod
Future<List<Sale>> todaySales(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  // Use local time to determine "today" for the user's timezone
  final today = DateTime.now().toLocal();
  final result = await ref.read(salesRepositoryProvider).getSales(
    branchId: branchId,
    date: today,
  );
  return result.fold(
    (failure) => [],
    (sales) => sales,
  );
}

/// Today's sales summary (count and total amount).
/// Uses vw_todays_sales view for optimized query.
/// Filtered by the current branch.
@riverpod
Future<TodaySalesSummary> todaySalesSummary(Ref ref) async {
  final branchId = ref.watch(currentBranchIdProvider);
  final pb = ref.read(pocketbaseProvider);
  final records = await pb
      .collection(PocketBaseCollections.vwTodaysSales)
      .getFullList(
        filter: branchId != null ? 'branch = "$branchId"' : null,
      );

  if (records.isEmpty) {
    return const TodaySalesSummary(count: 0, total: 0);
  }

  final record = records.first;
  return TodaySalesSummary(
    count: record.getIntValue('transaction_count'),
    total: record.getDoubleValue('total_revenue'),
  );
}
