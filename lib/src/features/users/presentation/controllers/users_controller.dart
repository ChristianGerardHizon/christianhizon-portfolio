import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/presentation/controllers/user_search_controller.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_controller.g.dart';

@riverpod
class UsersController extends _$UsersController {
  String? _buildFilter(String? query) {
    if (query == null) return 'isDeleted = false';
    final trimmed = query.trim();
    if (trimmed.isEmpty) return 'isDeleted = false';
    return 'name ~ "$trimmed" && isDeleted = false';
  }

  @override
  Future<PageResults<User>> build() async {
    final pageState = ref.watch(usersPageControllerProvider);
    final repo = ref.read(userRepositoryProvider);
    final query = ref.watch(userSearchControllerProvider);
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
