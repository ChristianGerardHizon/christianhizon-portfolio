import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/patients/data/species/patient_species_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_controller.g.dart';

@riverpod
class PatientSpeciesController extends _$PatientSpeciesController {
  String? _buildFilter() {
    return '${PatientSpeciesField.isDeleted} = false';
  }

  @override
  Future<List<PatientSpecies>> build() async {
    final repo = ref.read(patientSpeciesRepositoryProvider);
    final result = await repo
        .listAll(
          filter: _buildFilter(),
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
