import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/work_history_repository.dart';
import '../../domain/speaking_event.dart';
import '../../domain/work_history_item.dart';

part 'work_history_controller.g.dart';

/// Controller for fetching work history items.
@riverpod
class WorkHistoryController extends _$WorkHistoryController {
  @override
  Future<List<WorkHistoryItem>> build() async {
    final repo = ref.watch(workHistoryRepositoryProvider);
    final result = await repo.getWorkHistory();
    return result.fold(
      (failure) => [],
      (items) => items,
    );
  }
}

/// Controller for fetching speaking events.
@riverpod
class SpeakingEventsController extends _$SpeakingEventsController {
  @override
  Future<List<SpeakingEvent>> build() async {
    final repo = ref.watch(workHistoryRepositoryProvider);
    final result = await repo.getSpeakingEvents();
    return result.fold(
      (failure) => [],
      (events) => events,
    );
  }
}
