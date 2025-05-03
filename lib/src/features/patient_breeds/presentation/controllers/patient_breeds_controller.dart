import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/patient_breeds/data/patient_breed_repository.dart';

import 'package:gym_system/src/features/patient_breeds/domain/patient_breed.dart';
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
