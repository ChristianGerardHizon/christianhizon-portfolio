import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/failure.dart';
import '../../../../core/foundation/type_defs.dart';
import '../../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../../domain/speaking_event.dart';
import '../../domain/work_history_item.dart';

part 'work_history_repository.g.dart';

@Riverpod(keepAlive: true)
WorkHistoryRepository workHistoryRepository(Ref ref) {
  return WorkHistoryRepository(pb: ref.watch(pocketbaseProvider));
}

class WorkHistoryRepository {
  final PocketBase pb;

  WorkHistoryRepository({required this.pb});

  RecordService get _workHistoryCollection =>
      pb.collection(PocketBaseCollections.workHistory);

  RecordService get _speakingEventsCollection =>
      pb.collection(PocketBaseCollections.speakingEvents);

  WorkHistoryItem _workHistoryFromRecord(RecordModel record) {
    final data = record.toJson();

    // Parse responsibilities from JSON
    final rawResponsibilities = data['responsibilities'];
    final responsibilities = <String>[];
    if (rawResponsibilities is List) {
      for (final item in rawResponsibilities) {
        responsibilities.add(item.toString());
      }
    }

    // Parse achievements from JSON
    final rawAchievements = data['achievements'];
    final achievements = <WorkAchievement>[];
    if (rawAchievements is List) {
      for (final item in rawAchievements) {
        if (item is Map) {
          achievements.add(WorkAchievement(
            title: item['title']?.toString() ?? '',
            description: item['description']?.toString() ?? '',
          ));
        }
      }
    }

    // Parse techStack from JSON
    final rawTechStack = data['techStack'];
    final techStack = <String>[];
    if (rawTechStack is List) {
      for (final item in rawTechStack) {
        techStack.add(item.toString());
      }
    }

    return WorkHistoryItem(
      id: record.id,
      company: data['company']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      startDate: data['startDate']?.toString() ?? '',
      endDate: data['endDate']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      responsibilities: responsibilities,
      achievements: achievements,
      techStack: techStack,
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
    );
  }

  SpeakingEvent _speakingEventFromRecord(RecordModel record) {
    final data = record.toJson();
    return SpeakingEvent(
      id: record.id,
      title: data['title']?.toString() ?? '',
      organization: data['organization']?.toString() ?? '',
      date: data['date']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      type: data['type']?.toString() ?? '',
      sortOrder: (data['sortOrder'] as num?)?.toInt() ?? 0,
    );
  }

  /// Get all work history items, sorted by sortOrder.
  FutureEither<List<WorkHistoryItem>> getWorkHistory() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _workHistoryCollection.getFullList(
          sort: 'sortOrder',
        );
        return result.map(_workHistoryFromRecord).toList();
      },
      Failure.handle,
    ).run();
  }

  /// Get all speaking events, sorted by sortOrder.
  FutureEither<List<SpeakingEvent>> getSpeakingEvents() async {
    return TaskEither.tryCatch(
      () async {
        final result = await _speakingEventsCollection.getFullList(
          sort: 'sortOrder',
        );
        return result.map(_speakingEventFromRecord).toList();
      },
      Failure.handle,
    ).run();
  }
}
