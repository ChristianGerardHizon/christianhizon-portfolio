import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/pets/data/pet_repository.dart';
import 'package:gym_system/src/features/pets/domain/pet.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pet_update_controller.g.dart';

class PetUpdateState {
  final Pet pet;
  final Settings settings;

  PetUpdateState({required this.pet, required this.settings});
}

@riverpod
class PetUpdateController extends _$PetUpdateController {
  @override
  Future<PetUpdateState> build(String id) async {
    final petRepo = ref.read(petRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      final pet = await $(petRepo.get(id));
      return PetUpdateState(pet: pet, settings: settings);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
