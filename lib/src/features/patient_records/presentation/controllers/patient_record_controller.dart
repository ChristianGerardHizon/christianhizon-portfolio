import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/patient_records/data/patient_record_repository.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_controller.g.dart';

@riverpod
class PatientRecordController extends _$PatientRecordController {
  @override
  Future<PatientRecord> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final patientRecord = await $(_getPatientRecord(id));

      return patientRecord;
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
