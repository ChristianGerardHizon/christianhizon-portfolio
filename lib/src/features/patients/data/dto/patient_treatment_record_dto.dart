import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/patient_treatment_record.dart';
import 'patient_treatment_dto.dart';

part 'patient_treatment_record_dto.mapper.dart';

/// Data Transfer Object for PatientTreatmentRecord from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientTreatmentRecord.
@MappableClass()
class PatientTreatmentRecordDto with PatientTreatmentRecordDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String treatment;
  final String patient;
  final String? date;
  final String? notes;
  final String? appointment;
  final bool isDeleted;
  final String? created;
  final String? updated;

  /// Expanded treatment object (when using expand).
  final PatientTreatmentDto? expandedTreatment;

  const PatientTreatmentRecordDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.treatment,
    required this.patient,
    this.date,
    this.notes,
    this.appointment,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedTreatment,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientTreatmentRecordDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Handle expanded treatment relation
    PatientTreatmentDto? treatmentDto;
    final treatmentExpanded = record.get<RecordModel?>('expand.treatment');
    if (treatmentExpanded != null) {
      treatmentDto = PatientTreatmentDto.fromRecord(treatmentExpanded);
    }

    return PatientTreatmentRecordDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      treatment: json['treatment'] as String? ?? '',
      patient: json['patient'] as String? ?? '',
      date: json['date'] as String?,
      notes: json['notes'] as String?,
      appointment: json['appointment'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedTreatment: treatmentDto,
    );
  }

  /// Converts the DTO to a domain PatientTreatmentRecord entity.
  PatientTreatmentRecord toEntity() {
    return PatientTreatmentRecord(
      id: id,
      treatmentId: treatment,
      patientId: patient,
      treatment: expandedTreatment?.toEntity(),
      date: parseToLocal(date),
      notes: notes,
      appointment: appointment,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }

  /// Converts entity to JSON for create operations.
  static Map<String, dynamic> toCreateJson(PatientTreatmentRecord record) {
    return {
      'treatment': record.treatmentId,
      'patient': record.patientId,
      'date': record.date?.toUtcIso8601(),
      'notes': record.notes,
      'appointment': record.appointment,
    };
  }

  /// Converts entity to JSON for update operations.
  static Map<String, dynamic> toUpdateJson(PatientTreatmentRecord record) {
    return {
      'treatment': record.treatmentId,
      'date': record.date?.toUtcIso8601(),
      'notes': record.notes,
      'appointment': record.appointment,
    };
  }
}
