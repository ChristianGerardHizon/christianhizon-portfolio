import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/patients/data/treatment_record/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment.dart';

import 'package:gym_system/src/features/patients/domain/patient_treatment_record.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment_record_search.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/treatment_record/patient_treatment_record_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_records_controller.g.dart';

@riverpod
class PatientTreatmentRecordsController
    extends _$PatientTreatmentRecordsController {
  String _buildFilter({
    String? patientId,
    PatientTreatment? treatment,
    PatientTreatmentRecordSearch? params,
  }) {
    final baseFilter = '${PatientTreatmentRecordField.isDeleted} = false';

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientTreatmentRecordField.id} ~ "$q"');

    final patientFilter = Option.of(patientId)
        .map((p) => "${PatientTreatmentRecordField.patient} = '$p'");

    final typeFilter = Option.of(treatment?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientTreatmentRecordField.type} ~ "${q}"');

    final result = [
      idFilter,
      Some(baseFilter),
      patientFilter,
      typeFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<PatientTreatmentRecord>> build({
    String? id,
    PatientTreatment? treatment,
  }) async {
    final pageState = ref.watch(patientTreatmentRecordsPageControllerProvider);
    final repo = ref.read(treatmentRecordRepositoryProvider);
    final searchParams =
        ref.watch(patientTreatmentRecordSearchControllerProvider);
    final result = await repo
        .list(
            filter: _buildFilter(
              patientId: id,
              params: searchParams,
              treatment: treatment,
            ),
            pageNo: pageState.page,
            pageSize: pageState.pageSize,
            sort: PocketbaseSortValue(
              sortKey: PatientTreatmentRecordField.created,
              isAsc: false,
            ))
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
