import 'package:dart_mappable/dart_mappable.dart';

import '../../appointments/domain/appointment_schedule.dart';
import '../../patients/domain/patient.dart';

part 'message.mapper.dart';

/// Status of an SMS message in the queue.
@MappableEnum()
enum MessageStatus {
  /// Waiting to be sent by the server cron job.
  pending,

  /// Successfully sent.
  sent,

  /// Failed to send.
  failed,

  /// Cancelled before sending.
  cancelled,
}

/// An SMS message queued for sending.
///
/// Messages are created by the app and picked up by a server cron job
/// that checks the [sendDateTime] field to determine when to send.
@MappableClass()
class Message with MessageMappable {
  const Message({
    required this.id,
    required this.phone,
    required this.content,
    required this.sendDateTime,
    this.status = MessageStatus.pending,
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

  /// PocketBase record ID.
  final String id;

  /// Recipient phone number.
  final String phone;

  /// Message content/body.
  final String content;

  /// Scheduled send date/time (server checks this).
  final DateTime sendDateTime;

  /// Message status.
  final MessageStatus status;

  /// FK to Patient (optional - for context).
  final String? patient;

  /// FK to AppointmentSchedule (optional - for context).
  final String? appointment;

  /// Internal notes.
  final String? notes;

  /// Actual send timestamp (set by server after sending).
  final DateTime? sentAt;

  /// Error details if failed (set by server).
  final String? errorMessage;

  /// FK to Branch.
  final String? branch;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Expanded patient relation (when loaded from repository).
  final Patient? patientExpanded;

  /// Expanded appointment relation (when loaded from repository).
  final AppointmentSchedule? appointmentExpanded;

  /// PocketBase collection name.
  static const collectionName = 'messages';

  /// Whether the message is still pending.
  bool get isPending => status == MessageStatus.pending;

  /// Whether the message was sent successfully.
  bool get isSent => status == MessageStatus.sent;

  /// Whether the message failed to send.
  bool get isFailed => status == MessageStatus.failed;

  /// Whether the message was cancelled.
  bool get isCancelled => status == MessageStatus.cancelled;

  /// Whether the message can be cancelled (only pending messages).
  bool get canCancel => status == MessageStatus.pending;

  /// Display name for the patient (from expanded or context).
  String? get patientDisplayName => patientExpanded?.name;
}
