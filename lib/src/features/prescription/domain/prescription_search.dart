import 'package:dart_mappable/dart_mappable.dart';

part 'prescription_search.mapper.dart';

@MappableClass()
class PrescriptionItemSearch with PrescriptionItemSearchMappable {
  final String? treatment;
  final String? diagnosis;

  PrescriptionItemSearch({required this.treatment, required this.diagnosis});

  static fromMap(Map<String, dynamic> raw) {
    return PrescriptionItemSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }  static const fromJson = PrescriptionItemSearchMapper.fromMap;

  static PrescriptionItemSearch buildQuery(
    String query, {
    bool includeTreatment = false,
    bool includeDiagnosis = false,
  }) {
    return PrescriptionItemSearch(
      treatment: includeTreatment ? query : null,
      diagnosis: includeDiagnosis ? query : null,
    );
  }

}
