import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'patient_species.mapper.dart';

@MappableClass()
class PatientSpecies extends PbRecord with PatientSpeciesMappable {
  final String name;

  PatientSpecies({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    this.name = '',
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static const fromMap = PatientSpeciesMapper.fromMap;
  static const fromJson = PatientSpeciesMapper.fromJson;
}
