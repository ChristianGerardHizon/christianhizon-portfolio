import 'package:dart_mappable/dart_mappable.dart';

part 'patient_search.mapper.dart';

@MappableClass()
class PatientSearch with PatientSearchMappable {
  final String? id;
  final String? name;

  PatientSearch({this.id, this.name});

  static fromMap(Map<String, dynamic> raw) {
    return PatientSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientSearchMapper.fromMap;

  static PatientSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return PatientSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }
}
