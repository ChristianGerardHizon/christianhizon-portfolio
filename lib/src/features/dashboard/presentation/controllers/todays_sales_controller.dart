import 'package:riverpod_annotation/riverpod_annotation.dart';

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
@riverpod
Future<TodaySalesSummary> todaySalesSummary(Ref ref) async {
  final sales = await ref.watch(todaySalesProvider.future);
  return TodaySalesSummary(
    count: sales.length,
    total: sales.fold<num>(0, (sum, sale) => sum + sale.totalAmount),
  );
}
