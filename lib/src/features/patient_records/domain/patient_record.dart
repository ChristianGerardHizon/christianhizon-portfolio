import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/hooks/pb_num_hook.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/core/hooks/pb_empty_hook.dart';

part 'patient_record.mapper.dart';

@MappableClass()
class PatientRecord extends PbRecord with PatientRecordMappable {
  final String patient;
  final String? diagnosis;
  final DateTime visitDate;
  final String? treatment;
  final String? notes;
  @MappableField(hook: PbEmptyHook())
  final String? branch;

  @MappableField(hook: PbNumHook())
  final num? weightInKg;

  final String? tests;

  PatientRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.patient,
    this.diagnosis,
    required this.visitDate,
    this.treatment,
    this.notes,
    super.isDeleted = false,
    super.created,
    super.updated,
    this.weightInKg,
    this.branch,
    this.tests,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientRecordMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = PatientRecordMapper.fromJson;

  String? get displayWeightInKg {
    // append kg to weightInKg
    if (weightInKg == null) return null;
    return weightInKg!.toStringAsFixed(2).toString() + ' kg';
  }
}
