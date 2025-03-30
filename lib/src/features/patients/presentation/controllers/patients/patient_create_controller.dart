import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_breed.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/breeds/patient_breeds_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/species/patient_species_controller.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_create_controller.g.dart';

class PatientCreateState {
  final List<PatientSpecies> species;
  final List<PatientBreed> breeds;

  PatientCreateState({required this.species, required this.breeds});
}

@riverpod
class PatientCreateController extends _$PatientCreateController {
  @override
  Future<PatientCreateState> build() async {
    final result = await TaskResult.Do(($) async {
      final species = await ref.read(patientSpeciesControllerProvider.future);
      final breeds = await ref.read(patientBreedsControllerProvider.future);

      return PatientCreateState(
        species: species,
        breeds: breeds,
      );
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
