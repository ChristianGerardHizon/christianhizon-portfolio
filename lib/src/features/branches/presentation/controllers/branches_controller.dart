import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/domain/branch_search.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branches_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branches_controller.g.dart';

@riverpod
class BranchesController extends _$BranchesController {
  String _buildFilter({
    BranchSearch? params,
  }) {
    final baseFilter = '${BranchField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${BranchField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${BranchField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<Branch>> build() async {
    final pageState = ref.watch(branchesPageControllerProvider);
    final repo = ref.read(branchRepositoryProvider);
    final searchParams = ref.watch(branchSearchControllerProvider);
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
