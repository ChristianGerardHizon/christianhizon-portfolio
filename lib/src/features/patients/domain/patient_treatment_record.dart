import 'package:dart_mappable/dart_mappable.dart';

import 'patient_treatment.dart';

part 'patient_treatment_record.mapper.dart';

/// Model representing an actual treatment record for a patient.
///
/// Links a patient to a treatment type with date and notes.
@MappableClass()
class PatientTreatmentRecord with PatientTreatmentRecordMappable {
  const PatientTreatmentRecord({
    required this.id,
    required this.treatmentId,
    required this.patientId,
    this.treatment,
    this.date,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to PatientTreatment.
  final String treatmentId;

  /// FK to Patient.
  final String patientId;

  /// Expanded treatment object (when populated).
  final PatientTreatment? treatment;

  /// Treatment date.
  final DateTime? date;

  /// Treatment notes.
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
