import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/reports_repository.dart';
import '../../domain/appointment_report.dart';
import 'report_period_controller.dart';

part 'appointment_report_controller.g.dart';

/// Fetches and provides appointment report data.
@riverpod
Future<AppointmentReport> appointmentReport(Ref ref) async {
  final period = ref.watch(reportPeriodControllerProvider);
  final branchId = ref.watch(currentBranchIdProvider);
  final repository = ref.read(reportsRepositoryProvider);

  final result = await repository.getAppointmentReport(
    startDate: period.startDate,
    endDate: period.endDate,
    branchId: branchId,
  );

  return result.fold(
    (failure) => throw failure,
    (report) => report,
  );
}
