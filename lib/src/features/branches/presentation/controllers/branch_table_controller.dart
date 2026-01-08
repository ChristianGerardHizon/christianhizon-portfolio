import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branch_table_controller.g.dart';

@riverpod
class BranchTableController extends _$BranchTableController {
  @override
  Future<List<Branch>> build(String tableKey) async {
    final repo = ref.read(branchRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${BranchField.isDeleted} = false';
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
  PageResults<Branch> result,
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
