import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/patient_treatment.dart';
import '../../domain/patient_treatment_record.dart';

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
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded treatment data
  final String? expandedTreatmentId;
  final String? expandedTreatmentName;
  final String? expandedTreatmentIcon;

  const PatientTreatmentRecordDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.treatment,
    required this.patient,
    this.date,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedTreatmentId,
    this.expandedTreatmentName,
    this.expandedTreatmentIcon,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientTreatmentRecordDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Handle expanded treatment relation
    String? expandedTreatmentId;
    String? expandedTreatmentName;
    String? expandedTreatmentIcon;

    final expand = json['expand'] as Map<String, dynamic>?;
    if (expand != null && expand['treatment'] != null) {
      final treatmentExpand = expand['treatment'] as Map<String, dynamic>;
      expandedTreatmentId = treatmentExpand['id'] as String?;
      expandedTreatmentName = treatmentExpand['name'] as String?;
      expandedTreatmentIcon = treatmentExpand['icon'] as String?;
    }

    return PatientTreatmentRecordDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      treatment: json['treatment'] as String? ?? '',
      patient: json['patient'] as String? ?? '',
      date: json['date'] as String?,
      notes: json['notes'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedTreatmentId: expandedTreatmentId,
      expandedTreatmentName: expandedTreatmentName,
      expandedTreatmentIcon: expandedTreatmentIcon,
    );
  }

  /// Converts the DTO to a domain PatientTreatmentRecord entity.
  PatientTreatmentRecord toEntity() {
    // Build expanded treatment if available
    PatientTreatment? expandedTreatment;
    if (expandedTreatmentId != null && expandedTreatmentName != null) {
      expandedTreatment = PatientTreatment(
        id: expandedTreatmentId!,
        name: expandedTreatmentName!,
        icon: expandedTreatmentIcon,
      );
    }

    return PatientTreatmentRecord(
      id: id,
      treatmentId: treatment,
      patientId: patient,
      treatment: expandedTreatment,
      date: date != null ? DateTime.tryParse(date!) : null,
      notes: notes,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(PatientTreatmentRecord record) {
    return {
      'treatment': record.treatmentId,
      'patient': record.patientId,
      'date': record.date?.toIso8601String(),
      'notes': record.notes,
    };
  }
}
