import 'package:dart_mappable/dart_mappable.dart';
import 'package:intl/intl.dart';

import '../../patients/domain/patient.dart';
import '../../patients/domain/patient_record.dart';

part 'appointment_schedule.mapper.dart';

/// Status of an appointment schedule.
@MappableEnum()
enum AppointmentScheduleStatus {
  scheduled,
  completed,
  missed,
  cancelled,
}

/// Appointment schedule domain model.
///
/// Represents a scheduled appointment for a patient.
@MappableClass()
class AppointmentSchedule with AppointmentScheduleMappable {
  const AppointmentSchedule({
    required this.id,
    required this.date,
    this.hasTime = true,
    this.notes,
    this.purpose,
    this.status = AppointmentScheduleStatus.scheduled,
    this.patient,
    this.patientTreatment = const [],
    this.patientTreatmentName = const [],
    this.patientRecords = const [],
    this.branch,
    this.patientName,
    this.ownerName,
    this.ownerContact,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.patientExpanded,
    this.patientRecordsExpanded = const [],
    this.autoCreateRecord = true,
  });

  /// PocketBase record ID.
  final String id;

  /// Appointment date/time.
  final DateTime date;

  /// Whether the time is specified (false = all-day appointment).
  final bool hasTime;

  /// Additional notes.
  final String? notes;

  /// Purpose/reason for the appointment.
  final String? purpose;

  /// Appointment status.
  final AppointmentScheduleStatus status;

  /// FK to Patient.
  final String? patient;

  /// FKs to PatientTreatment (treatment type catalog).
  final List<String> patientTreatment;

  /// Expanded patient treatment names (when loaded).
  final List<String> patientTreatmentName;

  /// List of linked PatientRecord IDs.
  final List<String> patientRecords;

  /// FK to Branch.
  final String? branch;

  /// Cached patient name for display.
  final String? patientName;

  /// Cached owner name for display.
  final String? ownerName;

  /// Cached owner contact info.
  final String? ownerContact;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Expanded patient relation (when loaded).
  final Patient? patientExpanded;

  /// Expanded patient records (when loaded).
  final List<PatientRecord> patientRecordsExpanded;

  /// Whether completing this appointment should automatically create treatment records.
  final bool autoCreateRecord;

  /// PocketBase collection name.
  static const collectionName = 'appointment_schedules';

  /// Returns formatted date string.
  String get displayDate {
    if (hasTime) {
      return DateFormat('MMM d, yyyy h:mm a').format(date);
    }
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Returns formatted time string (null if no time).
  String? get displayTime {
    if (!hasTime) return null;
    return DateFormat('h:mm a').format(date);
  }

  /// Returns only the date part formatted.
  String get displayDateOnly {
    return DateFormat('MMM d, yyyy').format(date);
  }

  /// Returns display name for patient.
  String get patientDisplayName {
    return patientExpanded?.name ?? patientName ?? 'Unknown Patient';
  }

  /// Returns display name for owner.
  String get ownerDisplayName {
    return patientExpanded?.owner ?? ownerName ?? '';
  }

  /// Returns owner contact display.
  String get ownerContactDisplay {
    return patientExpanded?.contactNumber ?? ownerContact ?? '';
  }

  /// Returns true if appointment is today.
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Returns true if appointment is in the past.
  bool get isPast {
    return date.isBefore(DateTime.now());
  }

  /// Returns true if appointment is upcoming.
  bool get isUpcoming {
    return date.isAfter(DateTime.now());
  }

  /// Returns true if appointment has linked records.
  bool get hasLinkedItems {
    return patientRecords.isNotEmpty;
  }

  /// Returns total count of linked items.
  int get linkedItemsCount {
    return patientRecords.length;
  }

  /// Returns true if appointment has treatments assigned.
  bool get hasTreatments => patientTreatment.isNotEmpty;

  /// Returns comma-separated display string for treatment names.
  String get treatmentNamesDisplay => patientTreatmentName.join(', ');
}
