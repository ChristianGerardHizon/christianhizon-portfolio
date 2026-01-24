import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import 'inventory_alerts_controller.dart';

part 'dashboard_kpi_provider.g.dart';

/// Count of products that are near expiration (within 30 days).
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.
@riverpod
Future<int> productsNearExpirationCount(Ref ref) async {
  return ref.watch(nearExpirationAlertsCountProvider.future);
}

/// Count of products that are expired.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.
@riverpod
Future<int> productsExpiredCount(Ref ref) async {
  return ref.watch(expiredAlertsCountProvider.future);
}

/// Count of active patients.
/// Uses vw_active_patients_count view for optimized query.
@riverpod
Future<int> activePatientsCount(Ref ref) async {
  final pb = ref.read(pocketbaseProvider);
  final records = await pb
      .collection(PocketBaseCollections.vwActivePatientsCount)
      .getFullList();
  if (records.isEmpty) return 0;
  return records.first.getIntValue('active_count');
}

/// Count of products with low stock.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.
@riverpod
Future<int> lowStockProductsCount(Ref ref) async {
  return ref.watch(lowStockAlertsCountProvider.future);
}

/// Record class for today's appointments breakdown.
class TodayAppointmentsBreakdown {
  const TodayAppointmentsBreakdown({
    required this.scheduled,
    required this.completed,
    required this.missed,
    required this.cancelled,
  });

  final int scheduled;
  final int completed;
  final int missed;
  final int cancelled;

  int get total => scheduled + completed + missed + cancelled;
}

/// Today's appointments breakdown by status.
/// Uses vw_todays_appointments view for optimized query.
@riverpod
Future<TodayAppointmentsBreakdown> todayAppointmentsBreakdown(Ref ref) async {
  final pb = ref.read(pocketbaseProvider);
  final records = await pb
      .collection(PocketBaseCollections.vwTodaysAppointments)
      .getFullList();

  var scheduled = 0;
  var completed = 0;
  var missed = 0;
  var cancelled = 0;

  for (final record in records) {
    final status = record.getStringValue('status');
    final count = record.getIntValue('count');
    switch (status) {
      case 'scheduled':
        scheduled = count;
      case 'completed':
        completed = count;
      case 'missed':
        missed = count;
      case 'cancelled':
        cancelled = count;
    }
  }

  return TodayAppointmentsBreakdown(
    scheduled: scheduled,
    completed: completed,
    missed: missed,
    cancelled: cancelled,
  );
}
