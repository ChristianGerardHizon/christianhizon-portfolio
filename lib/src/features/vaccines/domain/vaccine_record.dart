import 'package:dart_mappable/dart_mappable.dart';

part 'vaccine_record.mapper.dart';

@MappableClass()
class VaccineRecord with VaccineRecordMappable {
  final String id;

  final String type;
  final String patient;

  final DateTime? created;
  final DateTime? updated;

  static const fromMap = VaccineRecordMapper.fromMap;
  static const fromJson = VaccineRecordMapper.fromMap;

  VaccineRecord({
    required this.id,
    required this.type,
    required this.patient,
    required this.created,
    required this.updated,
  });

  static VaccineRecord customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
