import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/patient_files/data/patient_file_repository.dart';
import 'package:gym_system/src/features/patient_files/domain/patient_file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_file_controller.g.dart';

@riverpod
class PatientFileController extends _$PatientFileController {
  @override
  Future<PatientFile> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final patientFile = await $(_getPatientFile(id));

      return patientFile;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<PatientFile> _getPatientFile(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(patientFileRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
