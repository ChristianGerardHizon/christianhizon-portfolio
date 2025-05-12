import 'package:gym_system/src/features/patient_treaments/data/patient_treatment_repository.dart';
import 'package:gym_system/src/features/patient_treaments/domain/patient_treatment.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_controller.g.dart';

@riverpod
class PatientTreatmentController extends _$PatientTreatmentController {
  @override
  FutureOr<PatientTreatment> build(String id) async {
    final result =
        await ref.read(patientTreatmentRepositoryProvider).get(id).run();
    return result.fold(Future.error, Future.value);
  }
}
