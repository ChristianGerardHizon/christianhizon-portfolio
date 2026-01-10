import 'package:sannjosevet/src/features/organization/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branch_controller.g.dart';

@riverpod
class BranchController extends _$BranchController {
  @override
  Future<Branch> build(String id) async {
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
