import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/change_logs/data/change_log_repository.dart';
import 'package:gym_system/src/features/change_logs/domain/change_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_log_controller.g.dart';

class ChangeLogState {
  final ChangeLog changeLog;

  ChangeLogState(this.changeLog);
}

@riverpod
class ChangeLogController extends _$ChangeLogController {
  @override
  Future<ChangeLogState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final changeLog = await $(_getChangeLog(id));

      return ChangeLogState(changeLog);
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<ChangeLog> _getChangeLog(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(changeLogRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
