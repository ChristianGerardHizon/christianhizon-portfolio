import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/patients/data/record/patient_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient_record.dart';
import 'package:gym_system/src/features/patients/domain/patient_record_search.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/record/patient_record_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_records_controller.g.dart';

@riverpod
class PatientRecordsController extends _$PatientRecordsController {
  String _buildFilter({
    String? patientId,
    PatientRecordSearch? params,
  }) {
    final baseFilter = '${PatientRecordField.isDeleted} = false';

    final nameFilter = Option.of(params?.diagnosis)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientRecordField.diagnosis} ~ "$q"');

    final treatmentFilter = Option.of(params?.treatment)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientRecordField.treatment} ~ "$q"');

    final patientFilter =
        Option.of(patientId).map((p) => "${PatientRecordField.patient} = '$p'");

    final result = [
      nameFilter,
      Some(baseFilter),
      patientFilter,
      treatmentFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<PatientRecord>> build({String? id}) async {
    final pageState = ref.watch(patientRecordsPageControllerProvider);
    final repo = ref.read(patientRecordRepositoryProvider);
    final searchParams = ref.watch(patientRecordSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(patientId: id, params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
          sort: '+created',
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
