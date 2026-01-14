import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/patient_breed.dart';

part 'patient_breed_dto.mapper.dart';

/// Data Transfer Object for PatientBreed from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientBreed.
@MappableClass()
class PatientBreedDto with PatientBreedDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String speciesId;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientBreedDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    required this.speciesId,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientBreedDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PatientBreedDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      speciesId: json['species'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain PatientBreed entity.
  PatientBreed toEntity() {
    return PatientBreed(
      id: id,
      name: name,
      speciesId: speciesId,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
