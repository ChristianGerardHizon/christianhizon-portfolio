import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_controller.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_form_controller.g.dart';

class ProductFormState {
  final Product? product;
  final List<Branch> branches;

  ProductFormState({required this.product, this.branches = const []});
}

@riverpod
class ProductFormController extends _$ProductFormController {
  @override
  Future<ProductFormState> build(String? id) async {
    final productRepo = ref.read(productRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      final branches = await $(_getBranches());

      if (id == null) {
        return ProductFormState(product: null, branches: branches);
      }

      final product = await $(productRepo.get(id));
      return ProductFormState(product: product, branches: branches);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<List<Branch>> _getBranches() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(branchRepositoryProvider);
      final baseFilter = '${BranchField.isDeleted} = false';
      final result = await repo.listAll(filter: baseFilter).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.presentation);
  }
}
