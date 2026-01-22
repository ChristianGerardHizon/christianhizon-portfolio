import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../patients/data/repositories/patient_repository.dart';
import '../../../pos/data/repositories/sales_repository.dart';
import '../../../pos/domain/sale.dart';
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

/// Today's sales data.
@riverpod
Future<List<Sale>> todaySales(Ref ref) async {
  final result = await ref.read(salesRepositoryProvider).getSales(
    date: DateTime.now(),
  );
  return result.fold(
    (failure) => [],
    (sales) => sales,
  );
}

/// Record class for today's sales summary.
class TodaySalesSummary {
  const TodaySalesSummary({
    required this.count,
    required this.total,
  });

  final int count;
  final num total;
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

/// Count of active patients.
@riverpod
Future<int> activePatientsCount(Ref ref) async {
  final result = await ref.read(patientRepositoryProvider).fetchAll();
  return result.fold(
    (failure) => 0,
    (patients) => patients.length,
  );
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
@riverpod
TodayAppointmentsBreakdown todayAppointmentsBreakdown(Ref ref) {
  final appointmentsAsync = ref.watch(appointmentsControllerProvider);

  return appointmentsAsync.when(
    data: (appointments) {
      final today = DateTime.now();
      final todayAppointments = appointments.where((a) {
        final apptDate = a.date;
        return apptDate.year == today.year &&
            apptDate.month == today.month &&
            apptDate.day == today.day;
      }).toList();

      return TodayAppointmentsBreakdown(
        scheduled:
            todayAppointments.where((a) => a.status.name == 'scheduled').length,
        completed:
            todayAppointments.where((a) => a.status.name == 'completed').length,
        missed:
            todayAppointments.where((a) => a.status.name == 'missed').length,
        cancelled:
            todayAppointments.where((a) => a.status.name == 'cancelled').length,
      );
    },
    loading: () => const TodayAppointmentsBreakdown(
      scheduled: 0,
      completed: 0,
      missed: 0,
      cancelled: 0,
    ),
    error: (_, __) => const TodayAppointmentsBreakdown(
      scheduled: 0,
      completed: 0,
      missed: 0,
      cancelled: 0,
    ),
  );
}
