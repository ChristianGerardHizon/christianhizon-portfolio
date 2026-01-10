import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/core/hooks/date_time_hook.dart';
import 'package:sannjosevet/src/core/hooks/patient_sex_hook.dart';
import 'package:sannjosevet/src/core/hooks/pb_empty_hook.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/patients/breeds/domain/patient_breed.dart';
import 'package:sannjosevet/src/features/patients/species/domain/patient_species.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient extends PbRecord with PatientMappable {
  final String name;
  final List<String> images;
  @MappableField(hook: PbEmptyHook())
  final String? avatar;
  @MappableField(hook: PbEmptyHook())
  final String? species;
  final String? owner;
  final String? contactNumber;
  final String? email;
  final String? address;
  final String? breed;
  final String? color;

  @MappableField(hook: PatientSexHook())
  final PatientSex? sex;
  @MappableField(hook: PbEmptyHook())
  final String? branch;

  @MappableField(hook: DateTimeHook())
  final DateTime? dateOfBirth;

  final PatientRecordExpand expand;

  Patient({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    this.name = '',
    this.images = const [],
    this.avatar,
    this.species,
    this.branch,
    this.owner,
    this.contactNumber,
    this.email,
    this.address,
    this.breed,
    this.color,
    this.sex,
    this.dateOfBirth,
    required this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    final dateOfBirth = raw[PatientField.dateOfBirth];
    final updatedDateOfBirth = dateOfBirth == '' ? null : dateOfBirth;

    return PatientMapper.fromMap({
      ...raw,
      PatientField.dateOfBirth: updatedDateOfBirth,
    });
  }

  static const fromJson = PatientMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      PatientField.dateOfBirth: dateOfBirth,
      PatientField.species: expand.species,
      PatientField.breed: expand.breed,
      PatientField.created: created,
      PatientField.updated: updated,
    };
  }
}

@MappableClass()
class PatientRecordExpand with PatientRecordExpandMappable {
  final PatientSpecies? species;
  final PatientBreed? breed;

  final Branch? branch;

  PatientRecordExpand({
    this.species,
    this.breed,
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientRecordExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientRecordExpandMapper.fromJson;
}

@MappableEnum()
enum PatientSex {
  male,
  female,
}
