import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/reports_repository.dart';
import '../../domain/patient_report.dart';
import 'report_period_controller.dart';

part 'patient_report_controller.g.dart';

/// Fetches and provides patient report data.
@riverpod
Future<PatientReport> patientReport(Ref ref) async {
  final period = ref.watch(reportPeriodControllerProvider);
  final repository = ref.read(reportsRepositoryProvider);

  final result = await repository.getPatientReport(
    startDate: period.startDate,
    endDate: period.endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}
