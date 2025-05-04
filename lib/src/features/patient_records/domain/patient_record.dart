import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/hooks/pb_empty_hook.dart';
import 'package:gym_system/src/core/strings/fields.dart';

part 'patient_record.mapper.dart';

@MappableClass()
class PatientRecord extends PbRecord with PatientRecordMappable {
  final String patient;
  final String? diagnosis;
  final DateTime visitDate;
  final String? treatment;
  final String? notes;
  @MappableField(hook: PbEmptyHook())
  final String? branch;

  PatientRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.patient,
    this.diagnosis,
    required this.visitDate,
    this.treatment,
    this.notes,
    super.isDeleted = false,
    super.created,
    super.updated,
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientRecordMapper.fromMap({
      ...raw,
      PatientRecordField.followUpDate:
          raw[PatientRecordField.followUpDate] == ''
              ? null
              : raw[PatientRecordField.followUpDate],
    });
  }

  static const fromJson = PatientRecordMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
