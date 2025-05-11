import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_breeds/data/patient_breed_repository.dart';
import 'package:gym_system/src/features/patient_breeds/domain/patient_breed.dart';
import 'package:gym_system/src/features/patient_species/domain/patient_species.dart';
import 'package:gym_system/src/features/patient_species/presentation/controllers/patient_species_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_form_controller.g.dart';

class PatientSpeciesFormState {
  final PatientSpecies? patientSpecies;

  PatientSpeciesFormState({required this.patientSpecies});
}

@riverpod
class PatientSpeciesFormController extends _$PatientSpeciesFormController {
  @override
  Future<PatientSpeciesFormState> build(String? id) async {
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientSpeciesFormState(patientSpecies: null);
      }
      final species =
          await ref.watch(patientSpeciesControllerProvider(id).future);
      return PatientSpeciesFormState(patientSpecies: species);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
