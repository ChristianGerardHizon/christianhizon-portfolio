import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment.dart';

part 'patient_treatment_record.mapper.dart';

@MappableClass()
class PatientTreatmentRecord extends PbRecord
    with PatientTreatmentRecordMappable {
  final String type;
  final String patient;
  final DateTime? followUpDate;
  final DateTime? date;
  final String? notes;

  final PatientTreatmentRecordExpand? expand;

  PatientTreatmentRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.type,
    required this.patient,
    this.followUpDate,
    this.date,
    this.notes,
    this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentRecordMapper.fromMap({
      ...raw,
      PatientTreatmentRecordField.followUpDate:
          raw[PatientTreatmentRecordField.followUpDate] == ''
              ? null
              : raw[PatientTreatmentRecordField.followUpDate],
      PatientTreatmentRecordField.date:
          raw[PatientTreatmentRecordField.date] == ''
              ? null
              : raw[PatientTreatmentRecordField.date],
    });
  }

  static const fromJson = PatientTreatmentRecordMapper.fromJson;
}

@MappableClass()
class PatientTreatmentRecordExpand with PatientTreatmentRecordExpandMappable {
  final PatientTreatment? type;

  PatientTreatmentRecordExpand({
    this.type,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentRecordExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientTreatmentRecordExpandMapper.fromJson;
}
