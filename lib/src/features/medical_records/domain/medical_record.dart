import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/strings/fields.dart';

part 'medical_record.mapper.dart';

@MappableClass()
class MedicalRecord with MedicalRecordMappable {
  final String id;

  final String patient;
  final String? diagnosis;
  final DateTime visitDate;
  final String? treatment;
  final DateTime? followUpDate;
  final String? note;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  MedicalRecord({
    required this.id,
    required this.patient,
    this.created,
    this.updated,
    this.isDeleted = false,
    this.diagnosis,
    required this.visitDate,
    this.treatment,
    this.followUpDate,
    this.note,
  });

  static const fromMap = MedicalRecordMapper.fromMap;
  static const fromJson = MedicalRecordMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static MedicalRecord customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
        MedicalRecordField.followUpDate:
            raw[MedicalRecordField.followUpDate] == ''
                ? null
                : raw[MedicalRecordField.followUpDate],
      },
    );
  }
}
