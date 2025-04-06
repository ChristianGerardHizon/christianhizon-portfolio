import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';

part 'treatment_record.mapper.dart';

@MappableClass()
class TreatmentRecord with TreatmentRecordMappable {
  final String id;

  final String type;
  final String patient;

  final DateTime? followUpDate;
  final DateTime? date;
  final String? notes;

  final TreatmentRecordExpand? expand;

  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;
  final String domain;

  TreatmentRecord({
    required this.collectionId,
    required this.collectionName,
    required this.domain,
    required this.id,
    required this.type,
    required this.patient,
    this.followUpDate,
    this.date,
    this.notes,
    this.expand,
    required this.created,
    required this.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return {
      ...raw,
      TreatmentRecordField.followUpDate:
          raw[TreatmentRecordField.followUpDate] == ''
              ? null
              : raw[TreatmentRecordField.followUpDate],
      TreatmentRecordField.date: raw[TreatmentRecordField.date] == ''
          ? null
          : raw[TreatmentRecordField.date],
    };
  }

  static const fromJson = TreatmentRecordMapper.fromMap;
}

@MappableClass()
class TreatmentRecordExpand with TreatmentRecordExpandMappable {
  final Treatment? type;

  static fromMap(Map<String, dynamic> raw) {
    return TreatmentRecordExpandMapper.fromMap(
      {
        ...raw,
      },
    );
  }  static const fromJson = TreatmentRecordExpandMapper.fromMap;

  TreatmentRecordExpand({
    this.type,
  });


}
