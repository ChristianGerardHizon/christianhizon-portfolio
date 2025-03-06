import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/vaccines/data/vaccine_record/vaccine_record_repository.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_vaccine_record_controller.g.dart';

@riverpod
class PatientVaccineRecordController extends _$PatientVaccineRecordController {
  @override
  Future<PageResults<VaccineRecord>> build({
    required String patientId,
    required String historyTypeId,
  }) async {
    final repo = ref.read(historyRepositoryProvider);
    final query = 'patient = "$patientId" && type = "$historyTypeId"';
    final result = await repo
        .list(
          filter: 'isDeleted = false && ${query}',
          pageNo: 1,
          pageSize: 50,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
