import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/patient_treament_records/data/patient_treatment_record_repository.dart';
import 'package:sannjosevet/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_table_controller.g.dart';

@riverpod
class PatientTreatmentRecordTableController
    extends _$PatientTreatmentRecordTableController {
  @override
  Future<List<PatientTreatmentRecord>> build(
      String tableKey, String patientId) async {
    final repo = ref.watch(patientTreatmentRecordRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    // fix warning here
    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter =
        "${PatientTreatmentRecordField.isDeleted} = false && patient = '$patientId' ";
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
  PageResults<PatientTreatmentRecord> result,
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
