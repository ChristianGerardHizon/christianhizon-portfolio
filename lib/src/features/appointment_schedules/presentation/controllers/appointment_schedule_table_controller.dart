import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/models/pb_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_table_controller.g.dart';

@riverpod
class AppointmentScheduleTableController
    extends _$AppointmentScheduleTableController {
  @override
  Future<List<AppointmentSchedule>> build(
    String tableKey, {
    String? patientId,
    DateTime? date,
  }) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);

    final page = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.page),
    );
    final pageSize = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.pageSize),
    );
    final tableFilter = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.filter),
    );
    final notifier = ref.read(tableControllerProvider(tableKey).notifier);

    final baseFilter = '${AppointmentScheduleField.isDeleted} = false';
    final filter = Task.of(PocketbaseFilter(baseFilter: baseFilter))
        // 1. search filter
        .map((f) => f.wildCardFields(tableFilter, fields: ['patient.name']))
        // 2. patient filter
        .map((f) => _addPatientFilter(f, patientId))
        // 3. date filter
        .map((f) => _dateTimeFilter(f, date));

    final result = await filter
        .toTaskEither<Failure>()
        .flatMap((filter) => repo
            // 1. Fetch data
            .list(
              filter: filter.build(),
              pageNo: page,
              pageSize: pageSize,
              sort: '-updated',
            )
            .flatMap((result) => _handleSuccess(result, notifier)))
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<AppointmentSchedule> result,
  TableController notifier,
) {
  notifier.fetchSuccess(
    hasNext: result.hasNext,
    page: result.page,
    totalItems: result.totalItems,
    totalPages: result.totalPages,
  );
  return TaskResult.right(result);
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
/// an additional clause that filters on the given [date].
///
/// If [date] is null, then the original filter is returned.
PocketbaseFilter _dateTimeFilter(
  PocketbaseFilter filter,
  DateTime? date,
) {
  if (date == null) return filter;
  return filter.withinDate(date, field: AppointmentScheduleField.date);
}
