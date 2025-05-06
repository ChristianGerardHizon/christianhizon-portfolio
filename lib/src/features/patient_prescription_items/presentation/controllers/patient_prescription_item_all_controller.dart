import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_item_all_controller.g.dart';

@riverpod
class PatientPrescriptionItemAllController
    extends _$PatientPrescriptionItemAllController {
  @override
  Future<List<PatientPrescriptionItem>> build() async {
    final result = await TaskResult.Do(($) async {
      final patientTreatmentRecords = await $(_getPatientTreatmentRecord());

      return patientTreatmentRecords;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<List<PatientPrescriptionItem>> _getPatientTreatmentRecord() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(patientPrescriptionItemRepositoryProvider);
      final result = await repo
          .listAll(
            filter: '${PbField.isDeleted} = false',
          )
          .run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
