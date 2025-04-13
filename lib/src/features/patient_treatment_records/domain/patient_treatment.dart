import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'patient_treatment.mapper.dart';

@MappableClass()
class PatientTreatment extends PbRecord with PatientTreatmentMappable {
  final String name;
  final String? icon;

  PatientTreatment({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.icon,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientTreatmentMapper.fromJson;
}
