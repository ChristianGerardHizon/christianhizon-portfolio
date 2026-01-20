import 'package:dart_mappable/dart_mappable.dart';

part 'treatment_plan_item_status.mapper.dart';

/// Status of a treatment plan item (individual session).
@MappableEnum()
enum TreatmentPlanItemStatus {
  scheduled,
  booked,
  completed,
  missed,
  skipped,
}

/// Extension to get display names for treatment plan item statuses.
extension TreatmentPlanItemStatusX on TreatmentPlanItemStatus {
  String get displayName {
    switch (this) {
      case TreatmentPlanItemStatus.scheduled:
        return 'Scheduled';
      case TreatmentPlanItemStatus.booked:
        return 'Booked';
      case TreatmentPlanItemStatus.completed:
        return 'Completed';
      case TreatmentPlanItemStatus.missed:
        return 'Missed';
      case TreatmentPlanItemStatus.skipped:
        return 'Skipped';
    }
  }

  /// Returns the value to store in PocketBase.
  String get pocketbaseValue {
    switch (this) {
      case TreatmentPlanItemStatus.scheduled:
        return 'scheduled';
      case TreatmentPlanItemStatus.booked:
        return 'booked';
      case TreatmentPlanItemStatus.completed:
        return 'completed';
      case TreatmentPlanItemStatus.missed:
        return 'missed';
      case TreatmentPlanItemStatus.skipped:
        return 'skipped';
    }
  }

  /// Creates a status from a PocketBase string value.
  static TreatmentPlanItemStatus fromPocketbaseValue(String? value) {
    switch (value) {
      case 'scheduled':
        return TreatmentPlanItemStatus.scheduled;
      case 'booked':
        return TreatmentPlanItemStatus.booked;
      case 'completed':
        return TreatmentPlanItemStatus.completed;
      case 'missed':
        return TreatmentPlanItemStatus.missed;
      case 'skipped':
        return TreatmentPlanItemStatus.skipped;
      default:
        return TreatmentPlanItemStatus.scheduled;
    }
  }

  /// Whether this status indicates the item has been finalized.
  bool get isFinalized {
    return this == TreatmentPlanItemStatus.completed ||
        this == TreatmentPlanItemStatus.missed ||
        this == TreatmentPlanItemStatus.skipped;
  }

  /// Whether this status counts toward plan completion.
  bool get countsAsCompleted {
    return this == TreatmentPlanItemStatus.completed;
  }
}
