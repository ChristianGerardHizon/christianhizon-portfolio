import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:gym_system/src/features/pets/domain/pet.dart';
import 'package:gym_system/src/features/pets/presentation/controllers/pets_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pets_controller.g.dart';

@riverpod
class PetsController extends _$PetsController {
  @override
  Future<PageResults<Pet>> build() async {
    final pageState = ref.watch(petsPageControllerProvider);
    final repo = ref.read(petRepositoryProvider);
    final result = await repo
        .list(pageNo: pageState.page, pageSize: pageState.pageSize)
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
