import 'package:dart_mappable/dart_mappable.dart';

part 'prescription_item_create.mapper.dart';

@MappableClass()
class PrescriptionItemCreate with PrescriptionItemCreateMappable {
  final String medicalRecord;
  final String? medication;
  final String? dosage;
  final String? instruction;

  PrescriptionItemCreate({
    required this.medicalRecord,
    this.medication,
    this.dosage,
    this.instruction,
  });

  static const fromMap = PrescriptionItemCreateMapper.fromMap;
  static const fromJson = PrescriptionItemCreateMapper.fromMap;
}
