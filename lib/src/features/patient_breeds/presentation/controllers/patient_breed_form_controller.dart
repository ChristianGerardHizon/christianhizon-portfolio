import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/patient_breeds/data/patient_breed_repository.dart';
import 'package:sannjosevet/src/features/patient_breeds/domain/patient_breed.dart';
import 'package:sannjosevet/src/features/patient_species/domain/patient_species.dart';
import 'package:sannjosevet/src/features/patient_species/presentation/controllers/patient_species_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_breed_form_controller.g.dart';

class PatientBreedFormState {
  final PatientBreed? patientBreed;
  final PatientSpecies? patientSpecies;

  PatientBreedFormState({required this.patientBreed, this.patientSpecies});
}

@riverpod
class PatientBreedFormController extends _$PatientBreedFormController {
  @override
  Future<PatientBreedFormState> build(String? id,
      {String? patientSpeciesId}) async {
    final repo = ref.read(patientBreedRepositoryProvider);
    final species = patientSpeciesId is String
        ? await ref
            .read(patientSpeciesControllerProvider(patientSpeciesId).future)
        : null;
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientBreedFormState(
          patientBreed: null,
          patientSpecies: species,
        );
      }
      final patientBreed = await $(repo.get(id));
      return PatientBreedFormState(
        patientBreed: patientBreed,
        patientSpecies: species,
      );
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
