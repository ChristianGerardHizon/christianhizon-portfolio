import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/features/patients/breeds/data/patient_breed_repository.dart';

import 'package:sannjosevet/src/features/patients/breeds/domain/patient_breed.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_breeds_controller.g.dart';

@riverpod
class PatientBreedsController extends _$PatientBreedsController {
  String? _buildFilter() {
    return "${PatientBreedField.isDeleted} = false";
  }

  @override
  Future<List<PatientBreed>> build() async {
    final repo = ref.read(patientBreedRepositoryProvider);
    final result = await repo
        .listAll(
          filter: _buildFilter(),
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
