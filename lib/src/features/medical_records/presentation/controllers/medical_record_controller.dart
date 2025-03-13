import 'package:gym_system/src/features/medical_records/data/medical_record_repository.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_record_controller.g.dart';

@riverpod
class MedicalRecordController extends _$MedicalRecordController {
  @override
  Future<MedicalRecord> build(String id) async {
    final repo = ref.read(medicalRecordRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
