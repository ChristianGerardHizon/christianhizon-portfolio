import 'package:sannjosevet/src/features/patients/species/data/patient_species_repository.dart';
import 'package:sannjosevet/src/features/patients/species/domain/patient_species.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_controller.g.dart';

@riverpod
class PatientSpeciesController extends _$PatientSpeciesController {
  @override
  Future<PatientSpecies> build(String id) async {
    final repo = ref.read(patientSpeciesRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
