import 'package:dart_mappable/dart_mappable.dart';

part 'work_history_item.mapper.dart';

/// A single work history entry.
@MappableClass()
class WorkHistoryItem with WorkHistoryItemMappable {
  final String id;
  final String company;
  final String role;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> responsibilities;
  final List<WorkAchievement> achievements;
  final List<String> techStack;
  final int sortOrder;

  const WorkHistoryItem({
    required this.id,
    required this.company,
    required this.role,
    required this.startDate,
    this.endDate = '',
    this.description = '',
    this.responsibilities = const [],
    this.achievements = const [],
    this.techStack = const [],
    this.sortOrder = 0,
  });

  static const collectionName = 'workHistory';
}

/// An achievement within a work history entry.
@MappableClass()
class WorkAchievement with WorkAchievementMappable {
  final String title;
  final String description;

  const WorkAchievement({
    required this.title,
    this.description = '',
  });
}
