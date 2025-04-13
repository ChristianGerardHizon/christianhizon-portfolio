import 'package:dart_mappable/dart_mappable.dart';

part 'patient_record_search.mapper.dart';

@MappableClass()
class PatientRecordSearch with PatientRecordSearchMappable {
  final String? treatment;
  final String? diagnosis;

  PatientRecordSearch({required this.treatment, required this.diagnosis});

  static fromMap(Map<String, dynamic> raw) {
    return PatientRecordSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientRecordSearchMapper.fromMap;

  static PatientRecordSearch buildQuery(
    String query, {
    bool includeTreatment = false,
    bool includeDiagnosis = false,
  }) {
    return PatientRecordSearch(
      treatment: includeTreatment ? query : null,
      diagnosis: includeDiagnosis ? query : null,
    );
  }
}
