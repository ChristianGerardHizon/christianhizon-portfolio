import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../domain/patient.dart';

part 'patient_dto.mapper.dart';

/// Data Transfer Object for Patient from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Patient.
@MappableClass()
class PatientDto with PatientDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? species;
  final String? breed;
  final String? owner;
  final String? contactNumber;
  final String? email;
  final String? address;
  final String? color;
  final String? sex;
  final String? branch;
  final String? dateOfBirth;
  final String? avatar;
  final List<String> images;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.species,
    this.breed,
    this.owner,
    this.contactNumber,
    this.email,
    this.address,
    this.color,
    this.sex,
    this.branch,
    this.dateOfBirth,
    this.avatar,
    this.images = const [],
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Get expanded species name using the new get<T>() method
    // Returns empty string if not found, so check for that
    final speciesExpanded = record.get<String>('expand.species.name');
    final speciesName = speciesExpanded.isNotEmpty ? speciesExpanded : null;

    // Get expanded breed name using the new get<T>() method
    final breedExpanded = record.get<String>('expand.breed.name');
    final breedName = breedExpanded.isNotEmpty ? breedExpanded : null;

    return PatientDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      species: speciesName ?? json['species'] as String?,
      breed: breedName ?? json['breed'] as String?,
      owner: json['owner'] as String?,
      contactNumber: json['contactNumber'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      color: json['color'] as String?,
      sex: json['sex'] as String?,
      branch: json['branch'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      avatar: json['avatar'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain Patient entity.
  Patient toEntity({String? baseUrl}) {
    return Patient(
      id: id,
      name: name,
      species: species,
      speciesId: species,
      breed: breed,
      breedId: breed,
      owner: owner,
      contactNumber: contactNumber,
      email: email,
      address: address,
      color: color,
      sex: _parseSex(sex),
      branch: branch,
      dateOfBirth: dateOfBirth != null ? DateTime.tryParse(dateOfBirth!) : null,
      avatar: _buildAvatarUrl(baseUrl),
      images: images,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  PatientSex? _parseSex(String? sex) {
    if (sex == null || sex.isEmpty) return null;
    return PatientSex.values.where((e) => e.name == sex).firstOrNull;
  }

  String? _buildAvatarUrl(String? baseUrl) {
    if (avatar == null || avatar!.isEmpty || baseUrl == null) return null;
    return '$baseUrl/api/files/$collectionName/$id/$avatar';
  }
}
