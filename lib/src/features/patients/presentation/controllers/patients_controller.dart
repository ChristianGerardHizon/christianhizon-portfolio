import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  @override
  Future<List<Patient>> build(int page, {int pageSize = 50}) async {
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo.list(pageNo: page, pageSize: 50).run();
    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}
