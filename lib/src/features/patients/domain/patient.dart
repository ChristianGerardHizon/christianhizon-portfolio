import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/patients/domain/patient_breed.dart';
import 'package:gym_system/src/features/patients/domain/patient_species.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient with PatientMappable {
  final String id;

  final String name;
  final List<String> images;

  final String? avatar;

  final String? species;
  final String? owner;
  final String? contactNumber;
  final String? email;
  final String? address;
  final String? breed;
  final String? color;
  final String? sex;
  final DateTime? dateOfBirth;

  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;

  final PatientRecordExpand? expand;

  Patient({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    this.name = '',
    this.images = const [],
    this.owner,
    this.avatar,
    this.species,
    this.breed,
    this.sex,
    this.color,
    this.contactNumber,
    this.email,
    this.address,
    this.dateOfBirth,
    this.created,
    this.updated,
    this.expand,
  });

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    final dateOfBirth = raw[PatientField.dateOfBirth];
    final updatedDateOfBirth = dateOfBirth == '' ? null : dateOfBirth;
    return PatientMapper.fromMap(
      {
        ...raw,
        PatientField.dateOfBirth: updatedDateOfBirth,
      },
    );
  }

  static const fromJson = PatientMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      PatientField.dateOfBirth: dateOfBirth,
      PatientField.species: expand?.species,
      PatientField.breed: expand?.breed,
      PatientField.created: created,
      PatientField.updated: created,
    };
  }
}

@MappableClass()
class PatientRecordExpand with PatientRecordExpandMappable {
  final PatientSpecies? species;
  final PatientBreed? breed;

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return PatientRecordExpandMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientRecordExpandMapper.fromMap;

  PatientRecordExpand({
    this.species,
    this.breed,
  });
}
