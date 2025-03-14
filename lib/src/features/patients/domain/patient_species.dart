import 'package:dart_mappable/dart_mappable.dart';

part 'patient_species.mapper.dart';

@MappableClass()
class PatientSpecies with PatientSpeciesMappable {
  final String id;

  final String name;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  PatientSpecies({
    required this.id,
    this.name = '',
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  static const fromMap = PatientSpeciesMapper.fromMap;
  static const fromJson = PatientSpeciesMapper.fromMap;

  static PatientSpecies customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
