import 'package:dart_mappable/dart_mappable.dart';

part 'patient_treatment.mapper.dart';

/// Model representing a treatment type in the catalog.
///
/// This is the treatment type/definition (e.g., "Vaccination", "Deworming"),
/// not an actual treatment record for a patient.
@MappableClass()
class PatientTreatment with PatientTreatmentMappable {
  const PatientTreatment({
    required this.id,
    required this.name,
    this.icon,
    this.branch,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Treatment name (e.g., "Vaccination", "Deworming", "Surgery").
  final String name;

  /// Icon filename/identifier.
  final String? icon;

  /// FK to Branch.
  final String? branch;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
