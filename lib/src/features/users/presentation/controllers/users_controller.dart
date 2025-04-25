import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/users/domain/user_search.dart';
import 'package:gym_system/src/features/users/presentation/controllers/users_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_controller.g.dart';

@riverpod
class UsersController extends _$UsersController {
  String _buildFilter({
    UserSearch? params,
  }) {
    final baseFilter = '${UserField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${UserField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${UserField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<User>> build() async {
    final pageState = ref.watch(usersPageControllerProvider);
    final repo = ref.read(userRepositoryProvider);
    final searchParams = ref.watch(userSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
          sort: 'created+',
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
