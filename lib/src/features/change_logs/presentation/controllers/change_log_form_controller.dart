import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/change_logs/data/change_log_repository.dart';
import 'package:gym_system/src/features/change_logs/domain/change_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_log_form_controller.g.dart';
part 'change_log_form_controller.mapper.dart';

@MappableClass()
class ChangeLogState with ChangeLogStateMappable {
  final ChangeLog? changeLog;

  ChangeLogState({
    required this.changeLog,
  });
}

@riverpod
class ChangeLogFormController extends _$ChangeLogFormController {
  @override
  Future<ChangeLogState> build(String? id) async {
    final repo = ref.read(changeLogRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return ChangeLogState(changeLog: null);
      }

      final changeLog = await $(repo.get(id));

      return ChangeLogState(changeLog: changeLog);
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
