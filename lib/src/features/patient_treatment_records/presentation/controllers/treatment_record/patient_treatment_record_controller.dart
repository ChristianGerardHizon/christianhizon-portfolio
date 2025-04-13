import 'package:gym_system/src/features/patient_treatment_records/data/patient_treatment_record/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patient_treatment_records/domain/patient_treatment_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_controller.g.dart';

@riverpod
class PatientTreatmentRecordController
    extends _$PatientTreatmentRecordController {
  @override
  Future<PatientTreatmentRecord> build(String id) async {
    final repo = ref.read(treatmentRecordRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
