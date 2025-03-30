import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/domain/patient_breed.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/breeds/patient_breeds_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/species/patient_species_controller.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_update_controller.g.dart';

class PatientUpdateState {
  final Patient patient;
  final Settings settings;
  final List<PatientSpecies> species;
  final List<PatientBreed> breeds;

  PatientUpdateState({
    required this.patient,
    required this.settings,
    required this.species,
    required this.breeds,
  });
}

@riverpod
class PatientUpdateController extends _$PatientUpdateController {
  @override
  Future<PatientUpdateState> build(String id) async {
    final patientRepo = ref.read(patientRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);

    final species = await ref.read(patientSpeciesControllerProvider.future);
    final breeds = await ref.read(patientBreedsControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      final patient = await $(patientRepo.get(id));
      return PatientUpdateState(
          patient: patient,
          settings: settings,
          species: species,
          breeds: breeds);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
