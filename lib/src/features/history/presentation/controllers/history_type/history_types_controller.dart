import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/history/data/history_type/history_type_repository.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_types_controller.g.dart';

@riverpod
class HistoryTypesController extends _$HistoryTypesController {
  @override
  Future<PageResults<HistoryType>> build() async {
    final repo = ref.read(historyTypeRepositoryProvider);
    final result = await repo
        .list(
          filter: 'isDeleted = false',
          pageNo: 1,
          pageSize: 50,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
