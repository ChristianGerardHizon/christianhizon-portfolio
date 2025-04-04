import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/medical_records/data/medical_record_repository.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record_search.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_records_controller.g.dart';

@riverpod
class MedicalRecordsController extends _$MedicalRecordsController {
  String _buildFilter({
    String? patientId,
    MedicalRecordSearch? params,
  }) {
    final baseFilter = '${MedicalRecordField.isDeleted} = false';

    final nameFilter = Option.of(params?.diagnosis)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${MedicalRecordField.diagnosis} ~ "$q"');

    final treatmentFilter = Option.of(params?.treatment)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${MedicalRecordField.treatment} ~ "$q"');

    final patientFilter =
        Option.of(patientId).map((p) => "${MedicalRecordField.patient} = '$p'");

    final result = [
      nameFilter,
      Some(baseFilter),
      patientFilter,
      treatmentFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<MedicalRecord>> build({String? id}) async {
    final pageState = ref.watch(medicalRecordsPageControllerProvider);
    final repo = ref.read(medicalRecordRepositoryProvider);
    final searchParams = ref.watch(medicalRecordSearchControllerProvider);
    final result = await repo
        .list(
            filter: _buildFilter(patientId: id, params: searchParams),
            pageNo: pageState.page,
            pageSize: pageState.pageSize,
            sort: PocketbaseSortValue(
              sortKey: MedicalRecordField.vistDate,
              isAsc: false,
            ))
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
