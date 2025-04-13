import 'package:gym_system/src/features/patients/data/record/patient_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_record.dart';
import 'package:gym_system/src/features/patients/domain/patient_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_controller.g.dart';

@riverpod
class PatientRecordController extends _$PatientRecordController {
  @override
  Future<PatientRecord> build(String id) async {
    final repo = ref.read(patientRecordRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
