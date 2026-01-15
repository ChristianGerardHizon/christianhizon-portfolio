import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/patient_treatment.dart';

part 'patient_treatment_dto.mapper.dart';

/// Data Transfer Object for PatientTreatment from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain PatientTreatment.
@MappableClass()
class PatientTreatmentDto with PatientTreatmentDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? icon;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const PatientTreatmentDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.icon,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory PatientTreatmentDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    return PatientTreatmentDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain PatientTreatment entity.
  PatientTreatment toEntity() {
    return PatientTreatment(
      id: id,
      name: name,
      icon: icon,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(PatientTreatment treatment) {
    return {
      'name': treatment.name,
      'icon': treatment.icon,
    };
  }
}
