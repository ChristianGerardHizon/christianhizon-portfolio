import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/domain/patient_search.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patients_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_controller.g.dart';

@riverpod
class PatientsController extends _$PatientsController {
  String _buildFilter({
    PatientSearch? params,
  }) {
    final baseFilter = '${PatientField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${PatientField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<Patient>> build() async {
    final pageState = ref.watch(patientsPageControllerProvider);
    final repo = ref.read(patientRepositoryProvider);
    final searchParams = ref.watch(patientSearchControllerProvider);
    final result = await repo
        .list(
            filter: _buildFilter(params: searchParams),
            pageNo: pageState.page,
            pageSize: pageState.pageSize,
            sort: PocketbaseSortValue(
              sortKey: PatientField.created,
              isAsc: true,
            ))
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
