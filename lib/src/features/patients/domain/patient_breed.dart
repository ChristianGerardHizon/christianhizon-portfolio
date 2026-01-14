import 'package:dart_mappable/dart_mappable.dart';

part 'patient_breed.mapper.dart';

/// Patient breed domain model.
///
/// Represents an animal breed within a species (e.g., Labrador, Persian).
@MappableClass()
class PatientBreed with PatientBreedMappable {
  const PatientBreed({
    required this.id,
    required this.name,
    required this.speciesId,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Breed name (e.g., "Labrador", "Persian").
  final String name;

  /// Species FK ID - links to PatientSpecies.
  final String speciesId;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;
}
