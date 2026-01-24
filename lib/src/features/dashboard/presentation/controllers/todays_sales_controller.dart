import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../../pos/data/repositories/sales_repository.dart';
import '../../../pos/domain/sale.dart';

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
@riverpod
Future<List<Sale>> todaySales(Ref ref) async {
  // Use local time to determine "today" for the user's timezone
  final today = DateTime.now().toLocal();
  final result = await ref.read(salesRepositoryProvider).getSales(
    date: today,
  );
  return result.fold(
    (failure) => [],
    (sales) => sales,
  );
}

/// Today's sales summary (count and total amount).
/// Uses vw_todays_sales view for optimized query.
@riverpod
Future<TodaySalesSummary> todaySalesSummary(Ref ref) async {
  final pb = ref.read(pocketbaseProvider);
  final records =
      await pb.collection(PocketBaseCollections.vwTodaysSales).getFullList();

  if (records.isEmpty) {
    return const TodaySalesSummary(count: 0, total: 0);
  }

  final record = records.first;
  return TodaySalesSummary(
    count: record.getIntValue('transaction_count'),
    total: record.getDoubleValue('total_revenue'),
  );
}
