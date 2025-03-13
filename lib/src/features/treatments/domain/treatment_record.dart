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

  static const fromMap = TreatmentRecordMapper.fromMap;
  static const fromJson = TreatmentRecordMapper.fromMap;

  TreatmentRecord({
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

  static TreatmentRecord customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
        TreatmentRecordField.followUpDate:
            raw[TreatmentRecordField.followUpDate] == ''
                ? null
                : raw[TreatmentRecordField.followUpDate],
        TreatmentRecordField.date: raw[TreatmentRecordField.date] == ''
            ? null
            : raw[TreatmentRecordField.date],
      },
    );
  }
}

@MappableClass()
class TreatmentRecordExpand with TreatmentRecordExpandMappable {
  final Treatment? type;

  static const fromMap = TreatmentRecordExpandMapper.fromMap;
  static const fromJson = TreatmentRecordExpandMapper.fromMap;

  TreatmentRecordExpand({
    this.type,
  });

  static TreatmentRecordExpand customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
