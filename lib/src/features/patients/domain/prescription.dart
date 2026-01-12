import 'package:dart_mappable/dart_mappable.dart';

part 'prescription.mapper.dart';

/// Model representing a prescription item for a patient record.
@MappableClass()
class Prescription with PrescriptionMappable {
  const Prescription({
    required this.id,
    required this.recordId,
    required this.medication,
    this.dosage,
    this.instructions,
    this.date,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// FK to PatientRecord.
  final String recordId;

  /// Medication name.
  final String medication;

  /// Dosage information.
  final String? dosage;

  /// Usage instructions.
  final String? instructions;

  /// Prescription date.
  final DateTime? date;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
