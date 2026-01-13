import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/patient_record.dart';

part 'patient_record_dto.mapper.dart';

/// Data Transfer Object for PatientRecord from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientRecord.
@MappableClass()
class PatientRecordDto with PatientRecordDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String patient;
  final String? visitDate;
  final String? diagnosis;
  final String? treatment;
  final String? notes;
  final String? branch;
  final num? weightInKg;
  final String? tests;
  final String? temperature;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientRecordDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.patient,
    this.visitDate,
    this.diagnosis,
    this.treatment,
    this.notes,
    this.branch,
    this.weightInKg,
    this.tests,
    this.temperature,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientRecordDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PatientRecordDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      patient: json['patient'] as String? ?? '',
      visitDate: json['visitDate'] as String?,
      diagnosis: json['diagnosis'] as String?,
      treatment: json['treatment'] as String?,
      notes: json['notes'] as String?,
      branch: json['branch'] as String?,
      weightInKg: json['weightInKg'] as num?,
      tests: json['tests'] as String?,
      temperature: json['temperature'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain PatientRecord entity.
  PatientRecord toEntity() {
    return PatientRecord(
      id: id,
      patientId: patient,
      date: visitDate != null ? DateTime.tryParse(visitDate!) ?? DateTime.now() : DateTime.now(),
      diagnosis: diagnosis ?? '',
      weight: _formatWeight(weightInKg),
      temperature: temperature ?? '',
      treatment: treatment,
      notes: notes,
      tests: tests,
      branch: branch,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  String _formatWeight(num? weight) {
    if (weight == null) return '';
    return '${weight.toStringAsFixed(1)} kg';
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(PatientRecord record) {
    return {
      'patient': record.patientId,
      'visitDate': record.date.toIso8601String(),
      'diagnosis': record.diagnosis,
      'treatment': record.treatment,
      'notes': record.notes,
      'branch': record.branch,
      'weightInKg': _parseWeight(record.weight),
      'tests': record.tests,
      'temperature': record.temperature,
    };
  }

  static num? _parseWeight(String weight) {
    if (weight.isEmpty) return null;
    // Remove "kg" suffix and parse
    final cleanWeight = weight.replaceAll(RegExp(r'[^\d.]'), '');
    return num.tryParse(cleanWeight);
  }
}
