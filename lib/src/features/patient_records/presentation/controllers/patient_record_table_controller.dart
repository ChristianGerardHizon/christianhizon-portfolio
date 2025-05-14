import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/models/pb_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/patient_records/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_table_controller.g.dart';

@riverpod
class PatientRecordTableController extends _$PatientRecordTableController {
  @override
  Future<List<PatientRecord>> build(String tableKey) async {
    final repo = ref.watch(patientRecordRepositoryProvider);

    final page = ref
        .watch(tableControllerProvider(tableKey).select((state) => state.page));

    final pageSize = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.pageSize));

    final tableFilter = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.filter));

    // fix warning here
    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${PatientRecordField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo

        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter).build(),
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
  PageResults<PatientRecord> result,
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
