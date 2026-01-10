import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/patients/core/data/patient_repository.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_table_controller.g.dart';

@riverpod
class PatientTableController extends _$PatientTableController {
  @override
  Future<List<Patient>> build(String tableKey) async {
    final repo = ref.read(patientRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${PatientField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);
    final result = await repo

        // 1. Fetch data
        .list(
          filter: filterFunc
              .searchFields(
                tableFilter,
                fields: [
                  PatientField.name,
                  PatientField.owner,
                  PatientField.contactNumber,
                  PatientField.email
                ],
                isWildCard: true,
              )
              .build(),
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
