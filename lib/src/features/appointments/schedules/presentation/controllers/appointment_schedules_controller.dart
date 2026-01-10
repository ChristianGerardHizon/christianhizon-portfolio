import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/features/appointments/schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointments/schedules/domain/appointment_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedules_controller.g.dart';

@riverpod
class AppointmentSchedulesController extends _$AppointmentSchedulesController {
  @override
  FutureOr<List<AppointmentSchedule>> build({
    required String patientId,
    String? patientRecordId,
  }) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);
    final baseFilter = '${AppointmentScheduleField.isDeleted} = false';
    final filter = await Task.of(PocketbaseFilter(baseFilter: baseFilter))
        // 2. patient filter
        .map((f) => _addPatientFilter(f, patientId))
        // 3. patient record filter
        .map((f) => _addPatientRecordFilter(f, patientRecordId))
        .run();
    final result = await repo
        .listAll(
            filter: filter.build(), sort: '-${AppointmentScheduleField.date}')
        .run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}

/// Return a new filter that is the same as the input filter, but with
/// an additional clause for the given [patientId].
///
/// If [patientId] is null, then the original filter is returned.
PocketbaseFilter _addPatientFilter(
  PocketbaseFilter filter,
  String? patientId,
) {
  if (patientId == null) return filter;
  return filter.equal(patientId, field: AppointmentScheduleField.patient);
}

/// Return a new filter that is the same as the input filter, but with
/// an additional clause for the given [patientRecordId].
///
/// If [patientRecordId] is null, then the original filter is returned.
PocketbaseFilter _addPatientRecordFilter(
  PocketbaseFilter filter,
  String? patientRecordId,
) {
  if (patientRecordId == null) return filter;
  return filter.equal(patientRecordId,
      field: AppointmentScheduleField.patientRecord);
}
