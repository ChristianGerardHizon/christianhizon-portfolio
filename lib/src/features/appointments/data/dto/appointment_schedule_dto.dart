import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../patients/domain/patient.dart';
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
  final String? patientRecord;
  final String? branch;
  final String? patientName;
  final String? ownerName;
  final String? ownerContact;
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded patient fields
  final String? expandedPatientName;
  final String? expandedPatientOwner;
  final String? expandedPatientContact;
  final String? expandedPatientSpecies;
  final String? expandedPatientBreed;

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
    this.patientRecord,
    this.branch,
    this.patientName,
    this.ownerName,
    this.ownerContact,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedPatientName,
    this.expandedPatientOwner,
    this.expandedPatientContact,
    this.expandedPatientSpecies,
    this.expandedPatientBreed,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory AppointmentScheduleDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Extract expanded patient data using record.get
    final expandedPatientName = record.get<String>('expand.patient.name');
    final expandedPatientOwner = record.get<String>('expand.patient.owner');
    final expandedPatientContact = record.get<String>('expand.patient.contactNumber');
    final expandedPatientSpecies = record.get<String>('expand.patient.species');
    final expandedPatientBreed = record.get<String>('expand.patient.breed');

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
      patientRecord: json['patientRecord'] as String?,
      branch: json['branch'] as String?,
      patientName: json['patientName'] as String?,
      ownerName: json['ownerName'] as String?,
      ownerContact: json['ownerContact'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedPatientName: expandedPatientName.isNotEmpty ? expandedPatientName : null,
      expandedPatientOwner: expandedPatientOwner.isNotEmpty ? expandedPatientOwner : null,
      expandedPatientContact: expandedPatientContact.isNotEmpty ? expandedPatientContact : null,
      expandedPatientSpecies: expandedPatientSpecies.isNotEmpty ? expandedPatientSpecies : null,
      expandedPatientBreed: expandedPatientBreed.isNotEmpty ? expandedPatientBreed : null,
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
      date: date != null ? DateTime.tryParse(date!) ?? DateTime.now() : DateTime.now(),
      hasTime: hasTime,
      notes: notes,
      purpose: purpose,
      status: _parseStatus(status),
      patient: patient,
      patientRecord: patientRecord,
      branch: branch,
      patientName: patientName,
      ownerName: ownerName,
      ownerContact: ownerContact,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
      patientExpanded: patientExpanded,
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
      'date': appointment.date.toUtc().toIso8601String(),
      'hasTime': appointment.hasTime,
      'notes': appointment.notes,
      'purpose': appointment.purpose,
      'status': appointment.status.name,
      'patient': appointment.patient,
      'patientRecord': appointment.patientRecord,
      'branch': appointment.branch,
      'patientName': appointment.patientName,
      'ownerName': appointment.ownerName,
      'ownerContact': appointment.ownerContact,
    };
  }

  /// Converts status update to JSON.
  static Map<String, dynamic> toStatusJson(AppointmentScheduleStatus status) {
    return {'status': status.name};
  }
}
