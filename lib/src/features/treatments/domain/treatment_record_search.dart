import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';

part 'treatment_record_search.mapper.dart';

@MappableClass()
class TreatmentRecordSearch with TreatmentRecordSearchMappable {
  final String? id;
  final Treatment? type;

  TreatmentRecordSearch({this.id, this.type});

  static const fromMap = TreatmentRecordSearchMapper.fromMap;
  static const fromJson = TreatmentRecordSearchMapper.fromMap;

  static TreatmentRecordSearch buildQuery(
    String query, {
    bool id = false,
    Treatment? type,
  }) {
    return TreatmentRecordSearch(
      id: id ? query : null,
      type: type,
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
