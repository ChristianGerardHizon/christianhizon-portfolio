/// Patient record domain model for medical records/visits.
class PatientRecord {
  const PatientRecord({
    required this.id,
    required this.patientId,
    required this.date,
    required this.diagnosis,
    required this.weight,
    required this.temperature,
    this.notes,
  });

  final String id;
  final String patientId;
  final DateTime date;
  final String diagnosis;
  final String weight;
  final String temperature;
  final String? notes;
}
