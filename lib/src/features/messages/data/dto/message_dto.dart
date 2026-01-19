import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../appointments/data/dto/appointment_schedule_dto.dart';
import '../../../patients/data/dto/patient_dto.dart';
import '../../domain/message.dart';

part 'message_dto.mapper.dart';

/// Data Transfer Object for Message from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Message.
@MappableClass()
class MessageDto with MessageDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String phone;
  final String content;
  final String? sendDateTime;
  final String? status;
  final String? patient;
  final String? appointment;
  final String? notes;
  final String? sentAt;
  final String? errorMessage;
  final String? branch;
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded relation data
  final PatientDto? patientExpanded;
  final AppointmentScheduleDto? appointmentExpanded;

  const MessageDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.phone,
    required this.content,
    this.sendDateTime,
    this.status,
    this.patient,
    this.appointment,
    this.notes,
    this.sentAt,
    this.errorMessage,
    this.branch,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.patientExpanded,
    this.appointmentExpanded,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory MessageDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Parse expanded patient
    PatientDto? patientExpanded;
    final expand = json['expand'] as Map<String, dynamic>?;
    if (expand != null) {
      final patientData = expand['patient'] as Map<String, dynamic>?;
      if (patientData != null) {
        patientExpanded =
            PatientDto.fromRecord(RecordModel.fromJson(patientData));
      }
    }

    // Parse expanded appointment
    AppointmentScheduleDto? appointmentExpanded;
    if (expand != null) {
      final appointmentData = expand['appointment'] as Map<String, dynamic>?;
      if (appointmentData != null) {
        appointmentExpanded = AppointmentScheduleDto.fromRecord(
            RecordModel.fromJson(appointmentData));
      }
    }

    return MessageDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      content: json['content'] as String? ?? '',
      sendDateTime: json['sendDateTime'] as String?,
      status: json['status'] as String?,
      patient: json['patient'] as String?,
      appointment: json['appointment'] as String?,
      notes: json['notes'] as String?,
      sentAt: json['sentAt'] as String?,
      errorMessage: json['errorMessage'] as String?,
      branch: json['branch'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      patientExpanded: patientExpanded,
      appointmentExpanded: appointmentExpanded,
    );
  }

  /// Converts the DTO to a domain Message entity.
  Message toEntity() {
    return Message(
      id: id,
      phone: phone,
      content: content,
      sendDateTime: parseToLocalOrDefault(sendDateTime, DateTime.now()),
      status: _parseStatus(status),
      patient: patient,
      appointment: appointment,
      notes: notes,
      sentAt: parseToLocal(sentAt),
      errorMessage: errorMessage,
      branch: branch,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
      patientExpanded: patientExpanded?.toEntity(),
      appointmentExpanded: appointmentExpanded?.toEntity(),
    );
  }

  MessageStatus _parseStatus(String? status) {
    if (status == null || status.isEmpty) return MessageStatus.pending;
    return MessageStatus.values.where((e) => e.name == status).firstOrNull ??
        MessageStatus.pending;
  }

  /// Converts a domain Message to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(Message message) {
    return {
      'phone': message.phone,
      'content': message.content,
      'sendDateTime': message.sendDateTime.toUtc().toIso8601String(),
      'status': message.status.name,
      if (message.patient != null) 'patient': message.patient,
      if (message.appointment != null) 'appointment': message.appointment,
      if (message.notes != null) 'notes': message.notes,
      if (message.branch != null) 'branch': message.branch,
    };
  }

  /// Converts status update to JSON.
  static Map<String, dynamic> toStatusJson(MessageStatus status) {
    return {'status': status.name};
  }

  /// Converts retry operation to JSON.
  /// Resets status to pending, updates send time, and clears error fields.
  static Map<String, dynamic> toRetryJson(DateTime newSendDateTime) {
    return {
      'status': MessageStatus.pending.name,
      'sendDateTime': newSendDateTime.toUtc().toIso8601String(),
      'errorMessage': '',
      'sentAt': '',
    };
  }
}
