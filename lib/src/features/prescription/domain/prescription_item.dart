import 'package:dart_mappable/dart_mappable.dart';

part 'prescription_item.mapper.dart';

@MappableClass()
class PrescriptionItem with PrescriptionItemMappable {
  final String id;

  final String patientRecord;
  final String? medication;

  final String? instructions;
  final String? dosage;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;

  PrescriptionItem({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.patientRecord,
    this.medication = '',
    this.instructions,
    this.dosage,
    this.created,
    this.updated,
    this.isDeleted = false,
  });

  static PrescriptionItem fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return PrescriptionItemMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PrescriptionItemMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }
}
