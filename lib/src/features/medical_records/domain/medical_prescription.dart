import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_prescription_item.dart';

part 'medical_prescription.mapper.dart';

@MappableClass()
class MedicalPrescription with MedicalPrescriptionMappable {
  final String? note;
  final List<MedicalPrescriptionItem> items;

  MedicalPrescription({
    this.note,
    this.items = const [],
  });

  static const fromMap = MedicalPrescriptionMapper.fromMap;
  static const fromJson = MedicalPrescriptionMapper.fromMap;
}
