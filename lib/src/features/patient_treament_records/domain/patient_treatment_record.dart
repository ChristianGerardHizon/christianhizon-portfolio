import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';
import 'package:gym_system/src/features/patient_treaments/domain/patient_treatment.dart';

part 'patient_treatment_record.mapper.dart';

@MappableClass()
class PatientTreatmentRecord extends PbRecord
    with PatientTreatmentRecordMappable {
  final String treatment;
  final String patient;

  @MappableField(hook: DateTimeHook())
  final DateTime? date;
  final String? notes;

  final PatientTreatmentRecordExpand expand;

  PatientTreatmentRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.treatment,
    required this.patient,
    this.date,
    this.notes,
    required this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentRecordMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientTreatmentRecordMapper.fromJson;
}

@MappableClass()
class PatientTreatmentRecordExpand with PatientTreatmentRecordExpandMappable {
  final PatientTreatment treatment;

  PatientTreatmentRecordExpand({
    required this.treatment,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentRecordExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientTreatmentRecordExpandMapper.fromJson;
}
