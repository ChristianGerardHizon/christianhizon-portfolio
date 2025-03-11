import 'package:dart_mappable/dart_mappable.dart';

part 'treatment_record_search.mapper.dart';

@MappableClass()
class TreatmentRecordSearch with TreatmentRecordSearchMappable {
  final String? id;

  TreatmentRecordSearch({required this.id});

  static const fromMap = TreatmentRecordSearchMapper.fromMap;
  static const fromJson = TreatmentRecordSearchMapper.fromMap;

  static TreatmentRecordSearch buildQuery(
    String query, {
    bool id = false,
  }) {
    return TreatmentRecordSearch(
      id: id ? query : null,
    );
  }

  static TreatmentRecordSearch customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
