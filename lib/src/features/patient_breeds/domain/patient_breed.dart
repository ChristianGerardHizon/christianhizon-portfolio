import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';

part 'patient_breed.mapper.dart';

@MappableClass()
class PatientBreed extends PbRecord with PatientBreedMappable {
  final String name;
  final String species;

  PatientBreed({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    this.name = '',
    required this.species,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static const fromMap = PatientBreedMapper.fromMap;
  static const fromJson = PatientBreedMapper.fromJson;
}
