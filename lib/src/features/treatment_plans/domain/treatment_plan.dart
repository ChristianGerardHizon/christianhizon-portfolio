import 'package:dart_mappable/dart_mappable.dart';
import 'package:intl/intl.dart';

import '../../patients/domain/patient.dart';
import '../../patients/domain/patient_treatment.dart';
import 'treatment_plan_item.dart';
import 'treatment_plan_item_status.dart';
import 'treatment_plan_status.dart';

part 'treatment_plan.mapper.dart';

/// Model representing a treatment plan for a patient.
///
/// A treatment plan defines a series of scheduled treatment sessions
/// (e.g., "5 Glutathione sessions, 7 days apart").
@MappableClass()
class TreatmentPlan with TreatmentPlanMappable {
  const TreatmentPlan({
    required this.id,
    required this.patientId,
    this.patient,
    required this.treatmentId,
    this.treatment,
    required this.status,
    required this.startDate,
    this.title,
    this.notes,
    this.items = const [],
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to Patient.
  final String patientId;

  /// Expanded patient object (when populated).
  final Patient? patient;

  /// FK to PatientTreatment (treatment type).
  final String treatmentId;

  /// Expanded treatment object (when populated).
  final PatientTreatment? treatment;

  /// Current status of the plan.
  final TreatmentPlanStatus status;

  /// Plan start date.
  final DateTime startDate;

  /// Optional custom title. If empty, displayTitle generates one.
  final String? title;

  /// Plan-level notes.
  final String? notes;

  /// List of plan items (sessions). May be empty if not expanded.
  final List<TreatmentPlanItem> items;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns the treatment name from expanded relation or empty string.
  String get treatmentName => treatment?.name ?? '';

  /// Returns the display title. Uses custom title if set, otherwise generates one.
  String get displayTitle {
    if (title != null && title!.isNotEmpty) return title!;
    final dateStr = DateFormat('MMM d').format(startDate);
    return '$treatmentName - $dateStr';
  }

  /// Returns the patient name from expanded relation or empty string.
  String get patientName => patient?.name ?? '';

  /// Total number of items in the plan.
  int get totalCount => items.length;

  /// Number of completed items.
  int get completedCount {
    return items
        .where((item) => item.status == TreatmentPlanItemStatus.completed)
        .length;
  }

  /// Progress percentage (0.0 to 1.0).
  double get progressPercentage {
    if (totalCount == 0) return 0.0;
    return completedCount / totalCount;
  }

  /// Progress as a display string (e.g., "3/5").
  String get progressDisplay => '$completedCount/$totalCount';

  /// Whether any items are overdue.
  bool get hasOverdueItems {
    return items.any((item) => item.isOverdue);
  }

  /// The next scheduled (not completed/skipped/missed) item.
  TreatmentPlanItem? get nextScheduledItem {
    final pending = items.where((item) => item.isPending).toList();
    if (pending.isEmpty) return null;
    pending.sort((a, b) => a.expectedDate.compareTo(b.expectedDate));
    return pending.first;
  }

  /// Number of overdue items.
  int get overdueCount {
    return items.where((item) => item.isOverdue).length;
  }

  /// Whether the plan is active.
  bool get isActive => status == TreatmentPlanStatus.active;

  /// Whether all items have been finalized.
  bool get allItemsFinalized {
    if (items.isEmpty) return false;
    return items.every((item) => item.isFinalized);
  }
}
