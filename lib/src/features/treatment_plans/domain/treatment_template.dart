import 'package:dart_mappable/dart_mappable.dart';

import '../../patients/domain/patient_treatment.dart';

part 'treatment_template.mapper.dart';

/// Model representing a treatment plan template.
///
/// Templates allow quick setup of common treatment plans
/// (e.g., "Puppy Vaccination Series" with 5 sessions, 14 days apart).
@MappableClass()
class TreatmentTemplate with TreatmentTemplateMappable {
  const TreatmentTemplate({
    required this.id,
    required this.name,
    required this.treatmentId,
    this.treatment,
    required this.defaultSessionCount,
    required this.defaultIntervalDays,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Template name (e.g., "Puppy Vaccination Series").
  final String name;

  /// FK to PatientTreatment (treatment type).
  final String treatmentId;

  /// Expanded treatment object (when populated).
  final PatientTreatment? treatment;

  /// Default number of sessions for this template.
  final int defaultSessionCount;

  /// Default days between sessions.
  final int defaultIntervalDays;

  /// Default notes for plans created from this template.
  final String? notes;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns the treatment name from expanded relation or empty string.
  String get treatmentName => treatment?.name ?? '';
}
