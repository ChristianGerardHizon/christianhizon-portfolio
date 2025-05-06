import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/packages/pocketbase_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/appointment_schedule/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedule/domain/appointment_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_table_controller.g.dart';

@riverpod
class AppointmentScheduleTableController
    extends _$AppointmentScheduleTableController {
  @override
  Future<List<AppointmentSchedule>> build(String tableKey,
      {String? patientId}) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);

    final page = ref
        .watch(tableControllerProvider(tableKey).select((state) => state.page));
    final pageSize = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.pageSize));
    final tableFilter = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.filter));

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final optional = patientId != null
        ? "&& ${AppointmentScheduleField.patient} = '$patientId'"
        : '';
    final baseFilter =
        '${AppointmentScheduleField.isDeleted} = false ${optional}';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);
    final filter = filterFunc.searchName(tableFilter).build();
    final result = await repo

        // 1. Fetch data
        .list(
          filter: filter,
          pageNo: page,
          pageSize: pageSize,
          sort: '-updated',
        )

        // 2. success sideffect
        .flatMap((result) => _handleSuccess(result, notifier))

        // 3. run
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
