import 'package:dart_mappable/dart_mappable.dart';

part 'patient_record.mapper.dart';

/// Patient record domain model for medical records/visits.
@MappableClass()
class PatientRecord with PatientRecordMappable {
  const PatientRecord({
    required this.id,
    required this.patientId,
    required this.date,
    required this.diagnosis,
    required this.weight,
    required this.temperature,
    this.treatment,
    this.notes,
    this.tests,
    this.branch,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to Patient.
  final String patientId;

  /// Date of visit.
  final DateTime date;

  /// Diagnosis text.
  final String diagnosis;

  /// Animal weight (formatted string like "5.2 kg").
  final String weight;

  /// Temperature reading.
  final String temperature;

  /// Treatment applied.
  final String? treatment;

  /// Additional notes.
  final String? notes;

  /// Tests performed.
  final String? tests;

  /// FK to Branch.
  final String? branch;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
