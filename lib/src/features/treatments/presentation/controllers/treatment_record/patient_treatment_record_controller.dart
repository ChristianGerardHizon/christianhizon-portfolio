import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/treatments/data/treatment_record/treatment_record_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_controller.g.dart';

@riverpod
class PatientTreatmentRecordController
    extends _$PatientTreatmentRecordController {
  @override
  Future<PageResults<TreatmentRecord>> build({
    required String patientId,
    required String historyTypeId,
  }) async {
    final repo = ref.read(treatmentRepositoryProvider);
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
