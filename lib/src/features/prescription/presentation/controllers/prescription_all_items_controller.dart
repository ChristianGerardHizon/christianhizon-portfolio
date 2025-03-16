import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/prescription/data/prescription_item_repository.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prescription_all_items_controller.g.dart';

@riverpod
class PrescriptionAllItemsController
    extends _$PrescriptionAllItemsController {
  String _buildFilter({
    String? medicalRecordId,
  }) {
    final baseFilter = '${PrescriptionItemField.isDeleted} = false';

    final medicationFilter = Option.of(medicalRecordId)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PrescriptionItemField.medicalRecord} ~ "$q"');

    final result = [
      medicationFilter,
      Some(baseFilter),
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<List<PrescriptionItem>> build({required String id}) async {
    final repo = ref.read(prescriptionItemRepositoryProvider);
    final result = await repo
        .listAll(
          filter: _buildFilter(medicalRecordId: id),
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
