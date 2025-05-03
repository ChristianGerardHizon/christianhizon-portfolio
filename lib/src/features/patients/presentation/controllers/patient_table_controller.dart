import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/packages/pocketbase_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_table_controller.g.dart';

@riverpod
class PatientTableController extends _$PatientTableController {
  @override
  Future<List<Patient>> build(String tableKey) async {
    final repo = ref.read(patientRepositoryProvider);

    final page = ref
        .watch(tableControllerProvider(tableKey).select((state) => state.page));
    final pageSize = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.pageSize));
    final tableFilter = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.filter));

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${PatientField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);
    final result = await repo

        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter),
          pageNo: page,
          pageSize: pageSize,
          sort: '+created',
        )

        // 2. success sideffect
        .flatMap((result) => _handleSuccess(result, notifier))

        // 3. run
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<Patient> result,
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
