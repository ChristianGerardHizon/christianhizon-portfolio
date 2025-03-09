import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  String? _buildFilter(String? query) {
    if (query == null) return 'isDeleted = false';
    final trimmed = query.trim();
    if (trimmed.isEmpty) return 'isDeleted = false';
    return 'name ~ "$trimmed" && isDeleted = false';
  }

  @override
  Future<PageResults<Patient>> build() async {
    final pageState = ref.watch(patientsPageControllerProvider);
    final repo = ref.read(patientRepositoryProvider);
    final query = ref.watch(patientSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(query),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
