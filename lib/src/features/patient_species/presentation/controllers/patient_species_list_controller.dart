import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/features/patient_species/data/patient_species_repository.dart';
import 'package:sannjosevet/src/features/patient_species/domain/patient_species.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_species_list_controller.g.dart';

@riverpod
class PatientSpeciesListController extends _$PatientSpeciesListController {
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
