import 'package:dart_mappable/dart_mappable.dart';

part 'patient_prescription_search.mapper.dart';

@MappableClass()
class PatientPrescriptionItemSearch with PatientPrescriptionItemSearchMappable {
  final String? treatment;
  final String? diagnosis;

  PatientPrescriptionItemSearch(
      {required this.treatment, required this.diagnosis});

  static fromMap(Map<String, dynamic> raw) {
    return PatientPrescriptionItemSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientPrescriptionItemSearchMapper.fromMap;

  static PatientPrescriptionItemSearch buildQuery(
    String query, {
    bool includeTreatment = false,
    bool includeDiagnosis = false,
  }) {
    return PatientPrescriptionItemSearch(
      treatment: includeTreatment ? query : null,
      diagnosis: includeDiagnosis ? query : null,
    );
  }
}
