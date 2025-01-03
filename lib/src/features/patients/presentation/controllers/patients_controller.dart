import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  @override
  Future<List<Patient>> build() async {
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo.list(pageNo: 1, pageSize: 1).run();
    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}
