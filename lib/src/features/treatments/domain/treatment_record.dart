import 'package:dart_mappable/dart_mappable.dart';

part 'treatment_record.mapper.dart';

@MappableClass()
class TreatmentRecord with TreatmentRecordMappable {
  final String id;

  final String type;
  final String patient;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = TreatmentRecordMapper.fromMap;
  static const fromJson = TreatmentRecordMapper.fromMap;

  TreatmentRecord({
    required this.id,
    required this.type,
    required this.patient,
    required this.created,
    required this.updated,
  });

  static TreatmentRecord customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
