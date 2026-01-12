/// Model representing a prescription for a patient record.
class Prescription {
  const Prescription({
    required this.id,
    required this.recordId,
    required this.medication,
    required this.dosage,
    required this.frequency,
    this.duration,
    this.instructions,
  });

  final String id;
  final String recordId;
  final String medication;
  final String dosage;
  final String frequency;
  final String? duration;
  final String? instructions;

  Prescription copyWith({
    String? id,
    String? recordId,
    String? medication,
    String? dosage,
    String? frequency,
    String? duration,
    String? instructions,
  }) {
    return Prescription(
      id: id ?? this.id,
      recordId: recordId ?? this.recordId,
      medication: medication ?? this.medication,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      instructions: instructions ?? this.instructions,
    );
  }
}
