import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_item_form_controller.g.dart';
part 'patient_prescription_item_form_controller.mapper.dart';

@MappableClass()
class PatientPrescriptionItemFormState
    with PatientPrescriptionItemFormStateMappable {
  final PatientPrescriptionItem? patientPrescriptionItem;
  final PatientRecord patientRecord;

  PatientPrescriptionItemFormState({
    this.patientPrescriptionItem,
    required this.patientRecord,
  });
}

@riverpod
class PatientPrescriptionItemFormController
    extends _$PatientPrescriptionItemFormController {
  @override
  Future<PatientPrescriptionItemFormState> build(
      {required String parentId, String? id}) async {
    final repo = ref.read(patientPrescriptionItemRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final patientRecord =
          await ref.read(patientRecordControllerProvider(parentId).future);

      if (id == null) {
        return PatientPrescriptionItemFormState(
          patientPrescriptionItem: null,
          patientRecord: patientRecord,
        );
      }

      final patientPrescriptionItem = await $(repo.get(id));

      return PatientPrescriptionItemFormState(
        patientPrescriptionItem: patientPrescriptionItem,
        patientRecord: patientRecord,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
