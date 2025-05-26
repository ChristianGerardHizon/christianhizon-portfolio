import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/hooks/date_time_hook.dart';

part 'patient_prescription_item.mapper.dart';

@MappableClass()
class PatientPrescriptionItem with PatientPrescriptionItemMappable {
  final String id;

  @MappableField(hook: DateTimeHook())
  final DateTime date;
  final String patientRecord;
  final String? medication;
  final String? instructions;
  final String? dosage;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;

  PatientPrescriptionItem({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.patientRecord,
    required this.date,
    this.medication = '',
    this.instructions,
    this.dosage,
    this.created,
    this.updated,
    this.isDeleted = false,
  });

  static PatientPrescriptionItem fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return PatientPrescriptionItemMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PatientPrescriptionItemMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }
}
