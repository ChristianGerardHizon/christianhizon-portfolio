import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_update_controller.g.dart';

@riverpod
class PatientUpdateController extends _$PatientUpdateController {
  @override
  Future<Patient> build(String id) async {
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
