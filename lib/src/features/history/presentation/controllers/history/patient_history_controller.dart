import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/history/data/history/history_repository.dart';
import 'package:gym_system/src/features/history/domain/history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_history_controller.g.dart';

@riverpod
class PatientHistoryController extends _$PatientHistoryController {
  @override
  Future<PageResults<History>> build({
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
