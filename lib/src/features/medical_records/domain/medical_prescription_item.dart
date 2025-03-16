import 'package:dart_mappable/dart_mappable.dart';

part 'medical_prescription_item.mapper.dart';

@MappableClass()
class MedicalPrescriptionItem with MedicalPrescriptionItemMappable {
  final String? note;
  final String? dosage;
  final String? medication;

  MedicalPrescriptionItem({
    this.note,
    this.dosage,
    this.medication,
  });

  static const fromMap = MedicalPrescriptionItemMapper.fromMap;
  static const fromJson = MedicalPrescriptionItemMapper.fromMap;
}
