import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/admins/domain/admin_search.dart';
import 'package:gym_system/src/features/admins/presentation/controllers/admins_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admins_controller.g.dart';

@riverpod
class AdminsController extends _$AdminsController {
  String _buildFilter({
    AdminSearch? params,
  }) {
    final baseFilter = '${AdminField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${AdminField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${AdminField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<Admin>> build() async {
    final pageState = ref.watch(adminsPageControllerProvider);
    final repo = ref.read(adminRepositoryProvider);
    final searchParams = ref.watch(adminSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
          sort: '+created',
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
