import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_update_controller.g.dart';

class ProductUpdateState {
  final Product product;
  final Settings settings;

  ProductUpdateState({required this.product, required this.settings});
}

@riverpod
class ProductUpdateController extends _$ProductUpdateController {
  @override
  Future<ProductUpdateState> build(String id) async {
    final productRepo = ref.read(productRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      final product = await $(productRepo.get(id));
      return ProductUpdateState(product: product, settings: settings);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
