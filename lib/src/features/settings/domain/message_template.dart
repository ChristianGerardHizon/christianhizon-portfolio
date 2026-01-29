import 'package:dart_mappable/dart_mappable.dart';

part 'message_template.mapper.dart';

/// Message template domain model.
///
/// Represents a reusable SMS template with placeholders for dynamic data.
/// Placeholders like {patientName}, {treatmentName}, etc. are replaced
/// with actual values when sending messages.
@MappableClass()
class MessageTemplate with MessageTemplateMappable {
  const MessageTemplate({
    required this.id,
    required this.name,
    required this.content,
    this.category,
    this.branch,
    this.isDefault = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Template name (e.g., "Appointment Reminder", "Vaccination Follow-up").
  final String name;

  /// Message content with placeholders.
  ///
  /// Supported placeholders:
  /// Patient: {patientName}, {patientPhone}, {ownerName}, {species}, {breed}, {email}, {address}, {patientPronoun}, {patientPronounObject}, {patientPronounPossessive}
  /// Branch: {branchName}, {branchAddress}, {branchPhone}
  /// Appointment: {appointmentDate}, {appointmentTime}, {appointmentDay}, {appointmentMonth}, {appointmentYear}, {appointmentHour}, {appointmentMinutes}, {appointmentAmPm}
  /// Treatment: {treatmentName}
  final String content;

  /// Template category for organization (e.g., "Reminders", "Follow-up", "Billing").
  final String? category;

  /// FK to Branch.
  final String? branch;

  /// Whether this is the default template for its category.
  final bool isDefault;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// List of all supported placeholder tokens.
  static const List<String> supportedPlaceholders = [
    // Patient data
    '{patientName}',
    '{patientPhone}',
    '{ownerName}',
    '{species}',
    '{breed}',
    '{email}',
    '{address}',
    '{patientPronoun}',
    '{patientPronounObject}',
    '{patientPronounPossessive}',
    // Branch data
    '{branchName}',
    '{branchAddress}',
    '{branchPhone}',
    // Appointment data
    '{appointmentDate}',
    '{appointmentTime}',
    '{appointmentDay}',
    '{appointmentMonth}',
    '{appointmentYear}',
    '{appointmentHour}',
    '{appointmentMinutes}',
    '{appointmentAmPm}',
    // Treatment data
    '{treatmentName}',
  ];

  /// Returns a list of placeholders used in this template's content.
  List<String> get usedPlaceholders {
    return supportedPlaceholders
        .where((placeholder) => content.contains(placeholder))
        .toList();
  }

  /// Returns true if this template uses any branch placeholders.
  bool get usesBranchData {
    return content.contains('{branchName}') ||
        content.contains('{branchAddress}') ||
        content.contains('{branchPhone}');
  }

  /// Returns true if this template uses any appointment placeholders.
  bool get usesAppointmentData {
    return content.contains('{appointmentDate}') ||
        content.contains('{appointmentTime}') ||
        content.contains('{appointmentDay}') ||
        content.contains('{appointmentMonth}') ||
        content.contains('{appointmentYear}') ||
        content.contains('{appointmentHour}') ||
        content.contains('{appointmentMinutes}') ||
        content.contains('{appointmentAmPm}');
  }
}
