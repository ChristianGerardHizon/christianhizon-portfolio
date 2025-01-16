import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  @override
  Future<PageResults<Patient>> build() async {
    final pageState = ref.watch(patientsPageControllerProvider);
    final repo = ref.read(patientRepositoryProvider);
    final result = await repo
        .list(pageNo: pageState.page, pageSize: pageState.pageSize)
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
