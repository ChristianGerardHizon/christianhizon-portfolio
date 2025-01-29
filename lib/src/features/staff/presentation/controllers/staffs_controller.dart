import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/staff/data/staff_repository.dart';
import 'package:gym_system/src/features/staff/domain/staff.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staff_search_controller.dart';
import 'package:gym_system/src/features/staff/presentation/controllers/staffs_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staffs_controller.g.dart';

@riverpod
class StaffsController extends _$StaffsController {
  String? _buildFilter(String? query) {
    if (query == null) return 'isDeleted = false';
    final trimmed = query.trim();
    if (trimmed.isEmpty) return 'isDeleted = false';
    return 'name ~ "$trimmed" && isDeleted = false';
  }

  @override
  Future<PageResults<Staff>> build() async {
    final pageState = ref.watch(staffsPageControllerProvider);
    final repo = ref.read(staffRepositoryProvider);
    final query = ref.watch(staffSearchControllerProvider);
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
