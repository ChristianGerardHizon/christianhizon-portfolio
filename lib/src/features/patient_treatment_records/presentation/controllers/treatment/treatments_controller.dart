import 'package:gym_system/src/features/patient_treatment_records/data/patient_treatment/patient_treatment_repository.dart';
import 'package:gym_system/src/features/patient_treatment_records/domain/patient_treatment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatments_controller.g.dart';

@riverpod
class TreatmentsController extends _$TreatmentsController {
  @override
  FutureOr<List<PatientTreatment>> build() async {
    final result = await ref.read(treatmentRepositoryProvider).listAll().run();
    return result.fold(Future.error, Future.value);
  }
}
