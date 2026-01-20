import 'package:dart_mappable/dart_mappable.dart';

import '../../appointments/domain/appointment_schedule.dart';
import 'treatment_plan_item_status.dart';

part 'treatment_plan_item.mapper.dart';

/// Model representing a single session within a treatment plan.
///
/// Each item represents a scheduled date for one treatment session.
@MappableClass()
class TreatmentPlanItem with TreatmentPlanItemMappable {
  const TreatmentPlanItem({
    required this.id,
    required this.planId,
    required this.sequence,
    required this.expectedDate,
    required this.status,
    this.appointmentId,
    this.appointment,
    this.completedDate,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to TreatmentPlan (parent plan).
  final String planId;

  /// Sequence number within the plan (1, 2, 3...).
  final int sequence;

  /// Expected/target date for this session.
  final DateTime expectedDate;

  /// Current status of this item.
  final TreatmentPlanItemStatus status;

  /// FK to AppointmentSchedule (when booked).
  final String? appointmentId;

  /// Expanded appointment object (when populated).
  final AppointmentSchedule? appointment;

  /// Actual completion date (when completed).
  final DateTime? completedDate;

  /// Item-specific notes.
  final String? notes;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Whether this item is overdue (past expected date and still scheduled).
  bool get isOverdue {
    if (status != TreatmentPlanItemStatus.scheduled) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expected = DateTime(
      expectedDate.year,
      expectedDate.month,
      expectedDate.day,
    );
    return expected.isBefore(today);
  }

  /// Returns a display string for the status.
  String get statusDisplay => status.displayName;

  /// Whether this item is awaiting action (scheduled or booked).
  bool get isPending {
    return status == TreatmentPlanItemStatus.scheduled ||
        status == TreatmentPlanItemStatus.booked;
  }

  /// Whether this item has been finalized (completed, missed, or skipped).
  bool get isFinalized => status.isFinalized;
}
