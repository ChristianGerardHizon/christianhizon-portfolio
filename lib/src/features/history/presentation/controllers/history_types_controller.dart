import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/history/data/history_type_repository.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:gym_system/src/features/history/presentation/controllers/history_type_search_controller.dart';
import 'package:gym_system/src/features/history/presentation/controllers/history_types_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_types_controller.g.dart';

@riverpod
class HistoryTypesController extends _$HistoryTypesController {
  String? _buildFilter(String? query) {
    if (query == null) return 'isDeleted = false';
    final trimmed = query.trim();
    if (trimmed.isEmpty) return 'isDeleted = false';
    return 'name ~ "$trimmed" && isDeleted = false';
  }

  @override
  Future<PageResults<HistoryType>> build() async {
    final pageState = ref.watch(historyTypesPageControllerProvider);
    final repo = ref.read(historyTypeRepositoryProvider);
    final query = ref.watch(historyTypeSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(query),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
