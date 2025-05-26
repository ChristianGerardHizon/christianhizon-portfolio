import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/patient_treaments/domain/patient_treatment.dart';
import 'package:sannjosevet/src/features/patient_treaments/presentation/controllers/patient_treatment_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_form_controller.g.dart';

class PatientTreatmentFormState {
  final PatientTreatment? projectTreatment;

  PatientTreatmentFormState({required this.projectTreatment});
}

@riverpod
class PatientTreatmentFormController extends _$PatientTreatmentFormController {
  @override
  Future<PatientTreatmentFormState> build(String? id) async {
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientTreatmentFormState(projectTreatment: null);
      }
      final projectTreatment =
          await ref.watch(patientTreatmentControllerProvider(id).future);
      return PatientTreatmentFormState(projectTreatment: projectTreatment);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
