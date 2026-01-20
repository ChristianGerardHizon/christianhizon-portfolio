import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../patients/domain/patient_treatment.dart';
import '../../domain/treatment_template.dart';

part 'treatment_template_dto.mapper.dart';

/// Data Transfer Object for TreatmentTemplate from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain TreatmentTemplate.
@MappableClass()
class TreatmentTemplateDto with TreatmentTemplateDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String treatment;
  final int defaultSessionCount;
  final int defaultIntervalDays;
  final String? notes;
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded treatment data
  final String? expandedTreatmentId;
  final String? expandedTreatmentName;
  final String? expandedTreatmentIcon;

  const TreatmentTemplateDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    required this.treatment,
    required this.defaultSessionCount,
    required this.defaultIntervalDays,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedTreatmentId,
    this.expandedTreatmentName,
    this.expandedTreatmentIcon,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory TreatmentTemplateDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Handle expanded treatment relation
    String? expandedTreatmentId;
    String? expandedTreatmentName;
    String? expandedTreatmentIcon;

    final expand = json['expand'] as Map<String, dynamic>?;
    if (expand != null && expand['treatment'] != null) {
      final treatmentExpand = expand['treatment'] as Map<String, dynamic>;
      expandedTreatmentId = treatmentExpand['id'] as String?;
      expandedTreatmentName = treatmentExpand['name'] as String?;
      expandedTreatmentIcon = treatmentExpand['icon'] as String?;
    }

    return TreatmentTemplateDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      treatment: json['treatment'] as String? ?? '',
      defaultSessionCount: json['defaultSessionCount'] as int? ?? 1,
      defaultIntervalDays: json['defaultIntervalDays'] as int? ?? 7,
      notes: json['notes'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedTreatmentId: expandedTreatmentId,
      expandedTreatmentName: expandedTreatmentName,
      expandedTreatmentIcon: expandedTreatmentIcon,
    );
  }

  /// Converts the DTO to a domain TreatmentTemplate entity.
  TreatmentTemplate toEntity() {
    // Build expanded treatment if available
    PatientTreatment? expandedTreatment;
    if (expandedTreatmentId != null && expandedTreatmentName != null) {
      expandedTreatment = PatientTreatment(
        id: expandedTreatmentId!,
        name: expandedTreatmentName!,
        icon: expandedTreatmentIcon,
      );
    }

    return TreatmentTemplate(
      id: id,
      name: name,
      treatmentId: treatment,
      treatment: expandedTreatment,
      defaultSessionCount: defaultSessionCount,
      defaultIntervalDays: defaultIntervalDays,
      notes: notes,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(TreatmentTemplate template) {
    return {
      'name': template.name,
      'treatment': template.treatmentId,
      'defaultSessionCount': template.defaultSessionCount,
      'defaultIntervalDays': template.defaultIntervalDays,
      'notes': template.notes,
    };
  }
}
