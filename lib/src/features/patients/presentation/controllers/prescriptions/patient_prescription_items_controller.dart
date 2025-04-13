import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/patients/data/precription/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_item.dart';
import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_search.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/prescriptions/patient_prescription_item_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_items_controller.g.dart';

@riverpod
class PatientPrescriptionItemsController
    extends _$PatientPrescriptionItemsController {
  String _buildFilter({
    String? patientId,
    PatientPrescriptionItemSearch? params,
  }) {
    final baseFilter = '${PrescriptionItemField.isDeleted} = false';

    final medicationFilter = Option.of(params?.diagnosis)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PrescriptionItemField.medication} ~ "$q"');

    final result = [
      medicationFilter,
      Some(baseFilter),
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<PrescriptionItem>> build({String? id}) async {
    final pageState = ref.watch(patientPrescriptionItemsPageControllerProvider);
    final repo = ref.read(patientPrescriptionItemRepositoryProvider);
    final searchParams =
        ref.watch(patientPrescriptionItemSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(patientId: id, params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
