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
  );
}
