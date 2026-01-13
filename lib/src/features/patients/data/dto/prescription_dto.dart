import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/prescription.dart';

part 'prescription_dto.mapper.dart';

/// Data Transfer Object for Prescription from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Prescription.
@MappableClass()
class PrescriptionDto with PrescriptionDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String patientRecord;
  final String? date;
  final String medication;
  final String? instructions;
  final String? dosage;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PrescriptionDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.patientRecord,
    this.date,
    required this.medication,
    this.instructions,
    this.dosage,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PrescriptionDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PrescriptionDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      patientRecord: json['patientRecord'] as String? ?? '',
      date: json['date'] as String?,
      medication: json['medication'] as String? ?? '',
      instructions: json['instructions'] as String?,
      dosage: json['dosage'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain Prescription entity.
  Prescription toEntity() {
    return Prescription(
      id: id,
      recordId: patientRecord,
      medication: medication,
      dosage: dosage,
      instructions: instructions,
      date: date != null ? DateTime.tryParse(date!) : null,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(Prescription prescription) {
    return {
      'patientRecord': prescription.recordId,
      'medication': prescription.medication,
      'dosage': prescription.dosage,
      'instructions': prescription.instructions,
      'date': prescription.date?.toIso8601String(),
    };
  }
}
