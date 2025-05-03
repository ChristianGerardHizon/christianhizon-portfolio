import 'package:gym_system/src/features/patient_treaments/data/patient_treatment_repository.dart';
import 'package:gym_system/src/features/patient_treaments/domain/patient_treatment.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatments_controller.g.dart';

@riverpod
class TreatmentsController extends _$TreatmentsController {
  @override
  FutureOr<List<PatientTreatment>> build() async {
    final result = await ref.read(treatmentRepositoryProvider).listAll().run();
    return result.fold(Future.error, Future.value);
  }
}
