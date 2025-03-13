import 'package:gym_system/src/features/treatments/data/treatment_record/treatment_record_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatment_record_controller.g.dart';

@riverpod
class TreatmentRecordController extends _$TreatmentRecordController {
  @override
  Future<TreatmentRecord> build(String id) async {
    final repo = ref.read(treatmentRecordRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
