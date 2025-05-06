import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_treament_records/data/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patient_treament_records/domain/patient_treatment_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_controller.g.dart';

class PatientTreatmentRecordState {
  final PatientTreatmentRecord patientTreatmentRecord;

  PatientTreatmentRecordState(this.patientTreatmentRecord);
}

@riverpod
class PatientTreatmentRecordController
    extends _$PatientTreatmentRecordController {
  @override
  Future<PatientTreatmentRecordState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final patientTreatmentRecord = await $(_getPatientTreatmentRecord(id));

      return PatientTreatmentRecordState(patientTreatmentRecord);
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<PatientTreatmentRecord> _getPatientTreatmentRecord(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(patientTreatmentRecordRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
