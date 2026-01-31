import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../patients/data/dto/patient_record_dto.dart';
import '../../../patients/domain/patient.dart';
import '../../../patients/domain/patient_record.dart';
import '../../domain/appointment_schedule.dart';

part 'appointment_schedule_dto.mapper.dart';

/// Data Transfer Object for AppointmentSchedule from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain AppointmentSchedule.
@MappableClass()
class AppointmentScheduleDto with AppointmentScheduleDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String? date;
  final bool hasTime;
  final String? notes;
  final String? purpose;
  final String? status;
  final String? patient;
  final List<String> patientTreatment;
  final List<String> patientRecords;
  final String? branch;
  final String? patientName;
  final String? ownerName;
  final String? ownerContact;
  final bool isDeleted;
  final bool autoCreateRecord;
  final String? created;
  final String? updated;

  // Expanded patient fields
  final String? expandedPatientName;
  final String? expandedPatientOwner;
  final String? expandedPatientContact;
  final String? expandedPatientSpecies;
  final String? expandedPatientBreed;

  // Expanded treatment type fields
  final List<String> expandedPatientTreatmentNames;

  // Expanded relation arrays
  final List<PatientRecord> expandedPatientRecords;

  const AppointmentScheduleDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    this.date,
    this.hasTime = true,
    this.notes,
    this.purpose,
    this.status,
    this.patient,
    this.patientTreatment = const [],
    this.patientRecords = const [],
    this.branch,
    this.patientName,
    this.ownerName,
    this.ownerContact,
    this.isDeleted = false,
    this.autoCreateRecord = true,
    this.created,
    this.updated,
    this.expandedPatientName,
    this.expandedPatientOwner,
    this.expandedPatientContact,
    this.expandedPatientSpecies,
    this.expandedPatientBreed,
    this.expandedPatientTreatmentNames = const [],
    this.expandedPatientRecords = const [],
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory AppointmentScheduleDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Extract expanded patient data using record.get
    final expandedPatientName = record.get<String>('expand.patient.name');
    final expandedPatientOwner = record.get<String>('expand.patient.owner');
    final expandedPatientContact = record.get<String>('expand.patient.contactNumber');
    // Extract species/breed names from nested expansion (patient.species, patient.breed)
    final expandedPatientSpecies = record.get<String>('expand.patient.expand.species.name');
    final expandedPatientBreed = record.get<String>('expand.patient.expand.breed.name');

    // Parse patientTreatment array (multi-relation field)
    final ptRaw = json['patientTreatment'];
    final patientTreatment = ptRaw is List ? ptRaw.cast<String>() : <String>[];

    // Parse expanded treatment names from multi-relation expand
    final expandedTreatmentNames = <String>[];
    final expand = json['expand'] as Map<String, dynamic>?;
    final ptExpand = expand?['patientTreatment'];
    if (ptExpand is List) {
      for (final item in ptExpand) {
        if (item is Map<String, dynamic>) {
          final name = item['name'] as String?;
          if (name != null && name.isNotEmpty) expandedTreatmentNames.add(name);
        }
      }
    }

    // Parse patientRecords array (relation array field)
    final patientRecordsRaw = json['patientRecords'];
    final patientRecords = patientRecordsRaw is List
        ? patientRecordsRaw.cast<String>()
        : <String>[];

    // Parse expanded patient records
    final expandedPatientRecords = <PatientRecord>[];
    if (expand != null) {
      final patientRecordsExpand = expand['patientRecords'];
      if (patientRecordsExpand is List) {
        for (final item in patientRecordsExpand) {
          if (item is Map<String, dynamic>) {
            final recordModel = RecordModel.fromJson(item);
            expandedPatientRecords.add(PatientRecordDto.fromRecord(recordModel).toEntity());
          }
        }
      }
    }

    return AppointmentScheduleDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      date: json['date'] as String?,
      hasTime: json['hasTime'] as bool? ?? true,
      notes: json['notes'] as String?,
      purpose: json['purpose'] as String?,
      status: json['status'] as String?,
      patient: json['patient'] as String?,
      patientTreatment: patientTreatment,
      patientRecords: patientRecords,
      branch: json['branch'] as String?,
      patientName: json['patientName'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerContact: json['ownerContact'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      autoCreateRecord: json['autoCreateRecord'] as bool? ?? true,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedPatientName: expandedPatientName.isNotEmpty ? expandedPatientName : null,
      expandedPatientOwner: expandedPatientOwner.isNotEmpty ? expandedPatientOwner : null,
      expandedPatientContact: expandedPatientContact.isNotEmpty ? expandedPatientContact : null,
      expandedPatientSpecies: expandedPatientSpecies.isNotEmpty ? expandedPatientSpecies : null,
      expandedPatientBreed: expandedPatientBreed.isNotEmpty ? expandedPatientBreed : null,
      expandedPatientTreatmentNames: expandedTreatmentNames,
      expandedPatientRecords: expandedPatientRecords,
    );
  }

  /// Converts the DTO to a domain AppointmentSchedule entity.
  AppointmentSchedule toEntity() {
    // Build expanded patient if we have expanded data
    Patient? patientExpanded;
    if (expandedPatientName != null && expandedPatientName!.isNotEmpty) {
      patientExpanded = Patient(
        id: patient ?? '',
        name: expandedPatientName!,
        owner: expandedPatientOwner,
        contactNumber: expandedPatientContact,
        species: expandedPatientSpecies,
        breed: expandedPatientBreed,
      );
    }

    return AppointmentSchedule(
      id: id,
      date: parseToLocalOrDefault(date, DateTime.now()),
      hasTime: hasTime,
      notes: notes,
      purpose: purpose,
      status: _parseStatus(status),
      patient: patient,
      patientTreatment: patientTreatment,
      patientTreatmentName: expandedPatientTreatmentNames,
      patientRecords: patientRecords,
      branch: branch,
      patientName: patientName,
      ownerName: ownerName,
      ownerContact: ownerContact,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
      patientExpanded: patientExpanded,
      patientRecordsExpanded: expandedPatientRecords,
      autoCreateRecord: autoCreateRecord,
    );
  }

  AppointmentScheduleStatus _parseStatus(String? status) {
    switch (status) {
      case 'scheduled':
        return AppointmentScheduleStatus.scheduled;
      case 'completed':
        return AppointmentScheduleStatus.completed;
      case 'missed':
        return AppointmentScheduleStatus.missed;
      case 'cancelled':
        return AppointmentScheduleStatus.cancelled;
      default:
        return AppointmentScheduleStatus.scheduled;
    }
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(AppointmentSchedule appointment) {
    return {
      'date': appointment.date.toUtcIso8601(),
      'hasTime': appointment.hasTime,
      'notes': appointment.notes,
      'purpose': appointment.purpose,
      'status': appointment.status.name,
      'patient': appointment.patient,
      'patientTreatment': appointment.patientTreatment,
      'patientRecords': appointment.patientRecords,
      'branch': appointment.branch,
      'patientName': appointment.patientName,
      'ownerName': appointment.ownerName,
      'ownerContact': appointment.ownerContact,
      'autoCreateRecord': appointment.autoCreateRecord,
    };
  }

  /// Converts status update to JSON.
  static Map<String, dynamic> toStatusJson(AppointmentScheduleStatus status) {
    return {'status': status.name};
  }
}
