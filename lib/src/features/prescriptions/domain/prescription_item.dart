import 'package:dart_mappable/dart_mappable.dart';

part 'prescription_item.mapper.dart';

@MappableClass()
class PrescriptionItem with PrescriptionItemMappable {
  final String id;

  final String medicalRecord;
  final String? medication;

  final String? instructions;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  PrescriptionItem({
    required this.id,
    required this.medicalRecord,
    this.medication = '',
    this.instructions,
    this.created,
    this.updated,
    this.isDeleted = false,
  });

  static const fromMap = PrescriptionItemMapper.fromMap;
  static const fromJson = PrescriptionItemMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static PrescriptionItem customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
