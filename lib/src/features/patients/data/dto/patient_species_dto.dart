import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/patient_species.dart';

part 'patient_species_dto.mapper.dart';

/// Data Transfer Object for PatientSpecies from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientSpecies.
@MappableClass()
class PatientSpeciesDto with PatientSpeciesDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientSpeciesDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientSpeciesDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PatientSpeciesDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain PatientSpecies entity.
  PatientSpecies toEntity() {
    return PatientSpecies(
      id: id,
      name: name,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
