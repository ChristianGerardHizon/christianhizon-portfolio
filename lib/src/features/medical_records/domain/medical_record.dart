import 'package:dart_mappable/dart_mappable.dart';

part 'medical_record.mapper.dart';

@MappableClass()
class MedicalRecord with MedicalRecordMappable {
  final String id;

  final String name;

  final DateTime? created;
  final DateTime? updated;

  MedicalRecord({
    required this.id,
    this.name = '',
    this.created,
    this.updated,
  });

  static const fromMap = MedicalRecordMapper.fromMap;
  static const fromJson = MedicalRecordMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static MedicalRecord customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
