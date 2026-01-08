import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/patient_treaments/data/patient_treatment_repository.dart';
import 'package:sannjosevet/src/features/patient_treaments/domain/patient_treatment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_table_controller.g.dart';

@riverpod
class PatientTreatmentTableController
    extends _$PatientTreatmentTableController {
  @override
  Future<List<PatientTreatment>> build(String tableKey) async {
    final repo = ref.watch(patientTreatmentRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = "${PatientTreatmentField.isDeleted} = false";
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo
        .list(
          filter: filterFunc.searchName(tableFilter).build(),
          pageNo: page,
          pageSize: pageSize,
          sort: '-updated',
        )
        .flatMap((result) => _handleSuccess(result, notifier))
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<PatientTreatment> result,
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
