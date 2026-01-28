import 'package:dart_mappable/dart_mappable.dart';

import 'patient_report.dart';

part 'appointment_report.mapper.dart';

/// Aggregated appointment data for a time period.
@MappableClass()
class AppointmentReport with AppointmentReportMappable {
  const AppointmentReport({
    required this.totalAppointments,
    required this.completedCount,
    required this.scheduledCount,
    required this.missedCount,
    required this.cancelledCount,
    required this.appointmentsByStatus,
    required this.appointmentsByDay,
    required this.appointmentsByPurpose,
    // Message breakdown fields
    this.totalMessages = 0,
    this.messageSentCount = 0,
    this.messageFailedCount = 0,
    this.messagePendingCount = 0,
    this.messageCancelledCount = 0,
    this.messagesByStatus = const {},
    this.messagesByDay = const [],
  });

  final int totalAppointments;
  final int completedCount;
  final int scheduledCount;
  final int missedCount;
  final int cancelledCount;

  /// Appointments by status (for pie chart).
  final Map<String, int> appointmentsByStatus;

  /// Appointments by day (for line/bar chart).
  final List<DailyCount> appointmentsByDay;

  /// Appointments by purpose (for bar chart).
  final Map<String, int> appointmentsByPurpose;

  // Message breakdown fields
  final int totalMessages;
  final int messageSentCount;
  final int messageFailedCount;
  final int messagePendingCount;
  final int messageCancelledCount;

  /// Messages by status (for pie chart).
  final Map<String, int> messagesByStatus;

  /// Messages by day (for bar chart).
  final List<DailyCount> messagesByDay;

  /// Completion rate as percentage.
  double get completionRate {
    if (totalAppointments == 0) return 0;
    return (completedCount / totalAppointments) * 100;
  }

  /// Miss rate as percentage.
  double get missRate {
    if (totalAppointments == 0) return 0;
    return (missedCount / totalAppointments) * 100;
  }

  /// Cancellation rate as percentage.
  double get cancellationRate {
    if (totalAppointments == 0) return 0;
    return (cancelledCount / totalAppointments) * 100;
  }

  /// Message success rate as percentage (sent / processed messages).
  double get messageSuccessRate {
    final processed = messageSentCount + messageFailedCount;
    if (processed == 0) return 0;
    return (messageSentCount / processed) * 100;
  }

  /// Message failure rate as percentage (failed / processed messages).
  double get messageFailureRate {
    final processed = messageSentCount + messageFailedCount;
    if (processed == 0) return 0;
    return (messageFailedCount / processed) * 100;
  }

  /// Empty report for initial/error states.
  static const empty = AppointmentReport(
    totalAppointments: 0,
    completedCount: 0,
    scheduledCount: 0,
    missedCount: 0,
    cancelledCount: 0,
    appointmentsByStatus: {},
    appointmentsByDay: [],
    appointmentsByPurpose: {},
    totalMessages: 0,
    messageSentCount: 0,
    messageFailedCount: 0,
    messagePendingCount: 0,
    messageCancelledCount: 0,
    messagesByStatus: {},
    messagesByDay: [],
  );
}
