import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/reports_repository.dart';
import '../../domain/appointment_report.dart';
import 'report_period_controller.dart';

part 'appointment_report_controller.g.dart';

/// Fetches and provides appointment report data.
@riverpod
Future<AppointmentReport> appointmentReport(Ref ref) async {
  final period = ref.watch(reportPeriodControllerProvider);
  final repository = ref.read(reportsRepositoryProvider);

  final result = await repository.getAppointmentReport(
    startDate: period.startDate,
    endDate: period.endDate,
  );

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}
