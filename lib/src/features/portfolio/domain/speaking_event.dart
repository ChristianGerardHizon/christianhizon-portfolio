import 'package:dart_mappable/dart_mappable.dart';

part 'speaking_event.mapper.dart';

/// A speaking or mentorship event.
@MappableClass()
class SpeakingEvent with SpeakingEventMappable {
  final String id;
  final String title;
  final String organization;
  final String date;
  final String description;
  final String type;
  final int sortOrder;

  const SpeakingEvent({
    required this.id,
    required this.title,
    required this.organization,
    required this.date,
    this.description = '',
    this.type = '',
    this.sortOrder = 0,
  });

  static const collectionName = 'speakingEvents';
}
