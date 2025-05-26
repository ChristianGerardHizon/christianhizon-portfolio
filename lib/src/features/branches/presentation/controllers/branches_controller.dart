import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/features/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branches_controller.g.dart';

@riverpod
class BranchesController extends _$BranchesController {
  @override
  Future<List<Branch>> build() async {
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PatientBreedField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
