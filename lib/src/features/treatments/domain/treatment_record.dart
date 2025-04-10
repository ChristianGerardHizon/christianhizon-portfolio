import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_object.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';

part 'treatment_record.mapper.dart';

@MappableClass()
class TreatmentRecord extends PbObject with TreatmentRecordMappable {
  final String type;
  final String patient;
  final DateTime? followUpDate;
  final DateTime? date;
  final String? notes;

  final TreatmentRecordExpand? expand;

  TreatmentRecord({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.type,
    required this.patient,
    this.followUpDate,
    this.date,
    this.notes,
    this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return TreatmentRecordMapper.fromMap({
      ...raw,
      TreatmentRecordField.followUpDate:
          raw[TreatmentRecordField.followUpDate] == ''
              ? null
              : raw[TreatmentRecordField.followUpDate],
      TreatmentRecordField.date: raw[TreatmentRecordField.date] == ''
          ? null
          : raw[TreatmentRecordField.date],
    });
  }

  static const fromJson = TreatmentRecordMapper.fromJson;
}

@MappableClass()
class TreatmentRecordExpand with TreatmentRecordExpandMappable {
  final Treatment? type;

  TreatmentRecordExpand({
    this.type,
  });

  static fromMap(Map<String, dynamic> raw) {
    return TreatmentRecordExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = TreatmentRecordExpandMapper.fromJson;
}
