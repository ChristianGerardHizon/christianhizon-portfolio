import 'package:dart_mappable/dart_mappable.dart';

import 'package:gym_system/src/features/patients/domain/patient_treatment.dart';

part 'patient_treatment_record_search.mapper.dart';

@MappableClass()
class PatientTreatmentRecordSearch with PatientTreatmentRecordSearchMappable {
  final String? id;

  PatientTreatmentRecordSearch({this.id});

  static fromMap(Map<String, dynamic> raw) {
    return PatientTreatmentRecordSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientTreatmentRecordSearchMapper.fromMap;

  static PatientTreatmentRecordSearch buildQuery(
    String query, {
    bool id = false,
    PatientTreatment? type,
  }) {
    return PatientTreatmentRecordSearch(
      id: id ? query : null,
    );
  }
}
