import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/reports_repository.dart';
import '../../domain/sales_report.dart';
import 'report_period_controller.dart';

part 'sales_report_controller.g.dart';

/// Fetches and provides sales report data.
@riverpod
Future<SalesReport> salesReport(Ref ref) async {
  final period = ref.watch(reportPeriodControllerProvider);
  final repository = ref.read(reportsRepositoryProvider);

  final result = await repository.getSalesReport(
    startDate: period.startDate,
    endDate: period.endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}
