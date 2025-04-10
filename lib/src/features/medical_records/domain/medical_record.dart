import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/strings/fields.dart';

part 'medical_record.mapper.dart';

@MappableClass()
class MedicalRecord extends PbRecord with MedicalRecordMappable {
  final String patient;
  final String? diagnosis;
  final DateTime visitDate;
  final String? treatment;
  final DateTime? followUpDate;
  final String? note;

  MedicalRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.patient,
    this.diagnosis,
    required this.visitDate,
    this.treatment,
    this.followUpDate,
    this.note,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return MedicalRecordMapper.fromMap({
      ...raw,
      MedicalRecordField.followUpDate:
          raw[MedicalRecordField.followUpDate] == ''
              ? null
              : raw[MedicalRecordField.followUpDate],
    });
  }

  static const fromJson = MedicalRecordMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
