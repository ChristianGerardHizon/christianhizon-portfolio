import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/reports_repository.dart';
import '../../domain/treatment_plan_report.dart';
import 'report_period_controller.dart';

part 'treatment_plan_report_controller.g.dart';

/// Fetches and provides treatment plan report data.
@riverpod
Future<TreatmentPlanReport> treatmentPlanReport(Ref ref) async {
  final period = ref.watch(reportPeriodControllerProvider);
  final repository = ref.read(reportsRepositoryProvider);

  final result = await repository.getTreatmentPlanReport(
    startDate: period.startDate,
    endDate: period.endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}
