import 'package:dart_mappable/dart_mappable.dart';

part 'patient_report.mapper.dart';

/// Aggregated patient data for a time period.
@MappableClass()
class PatientReport with PatientReportMappable {
  const PatientReport({
    required this.totalPatients,
    required this.newPatientsInPeriod,
    required this.patientsBySpecies,
    required this.patientsBySex,
    required this.registrationsByDay,
  });

  /// Total active patients.
  final int totalPatients;

  /// New patients registered in the period.
  final int newPatientsInPeriod;

  /// Patient count by species (for pie chart).
  final Map<String, int> patientsBySpecies;

  /// Patient count by sex (for pie chart).
  final Map<String, int> patientsBySex;

  /// New registrations by day (for line chart).
  final List<DailyCount> registrationsByDay;

  /// Empty report for initial/error states.
  static const empty = PatientReport(
    totalPatients: 0,
    newPatientsInPeriod: 0,
    patientsBySpecies: {},
    patientsBySex: {},
    registrationsByDay: [],
  );
}

/// Count for a single day.
@MappableClass()
class DailyCount with DailyCountMappable {
  const DailyCount({
    required this.date,
    required this.count,
  });

  final DateTime date;
  final int count;
}
