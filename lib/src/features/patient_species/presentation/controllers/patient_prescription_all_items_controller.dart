import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_all_items_controller.g.dart';

@riverpod
class PatientPrescriptionAllItemsController
    extends _$PatientPrescriptionAllItemsController {
  String _buildFilter({
    String? patientRecordId,
  }) {
    final baseFilter = '${PatientPrescriptionItemField.isDeleted} = false';

    final medicationFilter = Option.of(patientRecordId)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientPrescriptionItemField.patientRecord} ~ "$q"');

    final result = [
      medicationFilter,
      Some(baseFilter),
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<List<PatientPrescriptionItem>> build({required String id}) async {
    final repo = ref.read(patientPrescriptionItemRepositoryProvider);
    final result = await repo
        .listAll(
          filter: _buildFilter(patientRecordId: id),
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
