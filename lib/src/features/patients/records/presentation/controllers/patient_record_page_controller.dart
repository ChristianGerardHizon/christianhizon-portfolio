import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/patients/records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patients/records/presentation/controllers/patient_record_controller.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/controllers/patient_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_page_controller.g.dart';

class PatientRecordPageState {
  PatientRecordPageState({required this.patient, required this.patientRecord});
  final Patient patient;
  final PatientRecord patientRecord;
}

@riverpod
class PatientRecordPageController extends _$PatientRecordPageController {
  @override
  Future<PatientRecordPageState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final patientRecord =
          await ref.read(patientRecordControllerProvider(id).future);
      final patient = await ref
          .read(patientControllerProvider(patientRecord.patient).future);
      return PatientRecordPageState(
        patient: patient,
        patientRecord: patientRecord,
      );
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
