import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/treatments/data/treatment_record/treatment_record_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record_search.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment_record/treatment_record_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatment_records_controller.g.dart';

@riverpod
class TreatmentRecordsController extends _$TreatmentRecordsController {
  String _buildFilter({
    String? patientId,
    TreatmentRecordSearch? params,
  }) {
    final baseFilter = '${TreatmentRecordField.isDeleted} = false';

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${TreatmentRecordField.id} ~ "$q"');

    final patientFilter = Option.of(patientId)
        .map((p) => "${TreatmentRecordField.patient} = '$p'");

    final typeFilter = Option.of(params?.type?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${TreatmentRecordField.type} ~ "${q}"');

    final result = [
      idFilter,
      Some(baseFilter),
      patientFilter,
      typeFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<TreatmentRecord>> build({String? id}) async {
    final pageState = ref.watch(treatmentRecordsPageControllerProvider);
    final repo = ref.read(treatmentRecordRepositoryProvider);
    final searchParams = ref.watch(treatmentRecordSearchControllerProvider);
    final result = await repo
        .list(
            filter: _buildFilter(patientId: id, params: searchParams),
            pageNo: pageState.page,
            pageSize: pageState.pageSize,
            sort: PocketbaseSortValue(
              sortKey: TreatmentRecordField.created,
              isAsc: true,
            ))
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
