import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patients/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_controller.g.dart';

class PatientRecordState {
  final PatientRecord patientRecord;

  PatientRecordState(this.patientRecord);
}

@riverpod
class PatientRecordController extends _$PatientRecordController {
  @override
  Future<PatientRecordState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final patientRecord = await $(_getPatientRecord(id));

      return PatientRecordState(patientRecord);
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<PatientRecord> _getPatientRecord(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(patientRecordRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
