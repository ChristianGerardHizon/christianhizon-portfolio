import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/organization/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branch_form_controller.g.dart';

class BranchFormState {
  final Branch? branch;

  BranchFormState({required this.branch});
}

@riverpod
class BranchFormController extends _$BranchFormController {
  @override
  Future<BranchFormState> build(String? id) async {
    final branchRepo = ref.read(branchRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return BranchFormState(branch: null);
      }
      final branch = await $(branchRepo.get(id));
      return BranchFormState(branch: branch);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
