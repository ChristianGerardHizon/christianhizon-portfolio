import 'package:dart_mappable/dart_mappable.dart';

part 'patient_breed.mapper.dart';

@MappableClass()
class PatientBreed with PatientBreedMappable {
  final String id;

  final String name;
  final String species;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  PatientBreed({
    required this.id,
    this.name = '',
    required this.species,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  static const fromMap = PatientBreedMapper.fromMap;
  static const fromJson = PatientBreedMapper.fromMap;

  static PatientBreed customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
