import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/users/data/user_repository.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_table_controller.g.dart';

@riverpod
class UserTableController extends _$UserTableController {
  @override
  Future<List<User>> build(String tableKey) async {
    final repo = ref.watch(userRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    // fix warning here
    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${UserField.isDeleted} = false';
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
  PageResults<User> result,
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
