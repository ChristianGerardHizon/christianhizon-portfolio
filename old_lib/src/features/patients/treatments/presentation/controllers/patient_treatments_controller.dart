import 'package:sannjosevet/src/features/patients/treatments/data/patient_treatment_repository.dart';
import 'package:sannjosevet/src/features/patients/treatments/domain/patient_treatment.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatments_controller.g.dart';

@riverpod
class PatientTreatmentsController extends _$PatientTreatmentsController {
  @override
  FutureOr<List<PatientTreatment>> build() async {
    final result =
        await ref.read(patientTreatmentRepositoryProvider).listAll().run();
    return result.fold(Future.error, Future.value);
  }
}
