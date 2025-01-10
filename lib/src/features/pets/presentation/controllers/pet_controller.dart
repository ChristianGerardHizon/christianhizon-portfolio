import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:gym_system/src/features/pets/domain/pet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_controller.g.dart';

@riverpod
class PetController extends _$PetController {
  @override
  Future<Pet> build(String id) async {
    final repo = ref.read(petRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
