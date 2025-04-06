import 'package:dart_mappable/dart_mappable.dart';

part 'medical_record_search.mapper.dart';

@MappableClass()
class MedicalRecordSearch with MedicalRecordSearchMappable {
  final String? treatment;
  final String? diagnosis;

  MedicalRecordSearch({required this.treatment, required this.diagnosis});

  static fromMap(Map<String, dynamic> raw) {
    return MedicalRecordSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }
  static const fromJson = MedicalRecordSearchMapper.fromMap;

  static MedicalRecordSearch buildQuery(
    String query, {
    bool includeTreatment = false,
    bool includeDiagnosis = false,
  }) {
    return MedicalRecordSearch(
      treatment: includeTreatment ? query : null,
      diagnosis: includeDiagnosis ? query : null,
    );
  }

}
