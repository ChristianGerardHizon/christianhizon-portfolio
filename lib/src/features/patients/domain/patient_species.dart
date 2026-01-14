import 'package:dart_mappable/dart_mappable.dart';

part 'patient_species.mapper.dart';

/// Patient species domain model.
///
/// Represents an animal species (e.g., Dog, Cat, Bird).
@MappableClass()
class PatientSpecies with PatientSpeciesMappable {
  const PatientSpecies({
    required this.id,
    required this.name,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Species name (e.g., "Dog", "Cat").
  final String name;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
