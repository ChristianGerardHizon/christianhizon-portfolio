import 'package:dart_mappable/dart_mappable.dart';

part 'treatment_plan_status.mapper.dart';

/// Status of a treatment plan.
@MappableEnum()
enum TreatmentPlanStatus {
  active,
  completed,
  cancelled,
  onHold,
}

/// Extension to get display names for treatment plan statuses.
extension TreatmentPlanStatusX on TreatmentPlanStatus {
  String get displayName {
    switch (this) {
      case TreatmentPlanStatus.active:
        return 'Active';
      case TreatmentPlanStatus.completed:
        return 'Completed';
      case TreatmentPlanStatus.cancelled:
        return 'Cancelled';
      case TreatmentPlanStatus.onHold:
        return 'On Hold';
    }
  }

  /// Returns the value to store in PocketBase (snake_case).
  String get pocketbaseValue {
    switch (this) {
      case TreatmentPlanStatus.active:
        return 'active';
      case TreatmentPlanStatus.completed:
        return 'completed';
      case TreatmentPlanStatus.cancelled:
        return 'cancelled';
      case TreatmentPlanStatus.onHold:
        return 'on_hold';
    }
  }

  /// Creates a status from a PocketBase string value.
  static TreatmentPlanStatus fromPocketbaseValue(String? value) {
    switch (value) {
      case 'active':
        return TreatmentPlanStatus.active;
      case 'completed':
        return TreatmentPlanStatus.completed;
      case 'cancelled':
        return TreatmentPlanStatus.cancelled;
      case 'on_hold':
        return TreatmentPlanStatus.onHold;
      default:
        return TreatmentPlanStatus.active;
    }
  }
}
