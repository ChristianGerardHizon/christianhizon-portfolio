import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../patients/data/dto/patient_dto.dart';
import '../../../patients/domain/patient.dart';
import '../../../patients/domain/patient_treatment.dart';
import '../../domain/treatment_plan.dart';
import '../../domain/treatment_plan_item.dart';
import '../../domain/treatment_plan_status.dart';
import 'treatment_plan_item_dto.dart';

part 'treatment_plan_dto.mapper.dart';

/// Data Transfer Object for TreatmentPlan from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain TreatmentPlan.
@MappableClass()
class TreatmentPlanDto with TreatmentPlanDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String patient;
  final String treatment;
  final String status;
  final String startDate;
  final String? title;
  final String? notes;
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded patient data
  final Patient? expandedPatient;

  // Expanded treatment data
  final String? expandedTreatmentId;
  final String? expandedTreatmentName;
  final String? expandedTreatmentIcon;

  // Expanded items (when using back-relation expand)
  final List<TreatmentPlanItem> expandedItems;

  const TreatmentPlanDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.patient,
    required this.treatment,
    required this.status,
    required this.startDate,
    this.title,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedPatient,
    this.expandedTreatmentId,
    this.expandedTreatmentName,
    this.expandedTreatmentIcon,
    this.expandedItems = const [],
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory TreatmentPlanDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Handle expanded relations
    Patient? expandedPatient;
    String? expandedTreatmentId;
    String? expandedTreatmentName;
    String? expandedTreatmentIcon;
    List<TreatmentPlanItem> expandedItems = [];

    final expand = json['expand'] as Map<String, dynamic>?;
    if (expand != null) {
      // Expanded patient
      if (expand['patient'] != null) {
        final patientExpand = expand['patient'] as Map<String, dynamic>;
        final patientRecord = RecordModel.fromJson(patientExpand);
        expandedPatient = PatientDto.fromRecord(patientRecord).toEntity();
      }

      // Expanded treatment
      if (expand['treatment'] != null) {
        final treatmentExpand = expand['treatment'] as Map<String, dynamic>;
        expandedTreatmentId = treatmentExpand['id'] as String?;
        expandedTreatmentName = treatmentExpand['name'] as String?;
        expandedTreatmentIcon = treatmentExpand['icon'] as String?;
      }

      // Expanded items (back-relation: treatmentPlanItems_via_plan)
      final itemsExpand = expand['treatmentPlanItems_via_plan'];
      if (itemsExpand != null && itemsExpand is List) {
        for (final itemJson in itemsExpand) {
          if (itemJson is Map<String, dynamic>) {
            final itemRecord = RecordModel.fromJson(itemJson);
            expandedItems.add(
              TreatmentPlanItemDto.fromRecord(itemRecord).toEntity(),
            );
          }
        }
        // Sort items by sequence
        expandedItems.sort((a, b) => a.sequence.compareTo(b.sequence));
      }
    }

    return TreatmentPlanDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      patient: json['patient'] as String? ?? '',
      treatment: json['treatment'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      startDate: json['startDate'] as String? ?? '',
      title: json['title'] is String ? json['title'] as String : null,
      notes: json['notes'] is String ? json['notes'] as String : null,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedPatient: expandedPatient,
      expandedTreatmentId: expandedTreatmentId,
      expandedTreatmentName: expandedTreatmentName,
      expandedTreatmentIcon: expandedTreatmentIcon,
      expandedItems: expandedItems,
    );
  }

  /// Converts the DTO to a domain TreatmentPlan entity.
  TreatmentPlan toEntity() {
    // Build expanded treatment if available
    PatientTreatment? expandedTreatment;
    if (expandedTreatmentId != null && expandedTreatmentName != null) {
      expandedTreatment = PatientTreatment(
        id: expandedTreatmentId!,
        name: expandedTreatmentName!,
        icon: expandedTreatmentIcon,
      );
    }

    return TreatmentPlan(
      id: id,
      patientId: patient,
      patient: expandedPatient,
      treatmentId: treatment,
      treatment: expandedTreatment,
      status: TreatmentPlanStatusX.fromPocketbaseValue(status),
      startDate: parseToLocalOrDefault(startDate, DateTime.now()),
      title: title,
      notes: notes,
      items: expandedItems,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(TreatmentPlan plan) {
    return {
      'patient': plan.patientId,
      'treatment': plan.treatmentId,
      'status': plan.status.pocketbaseValue,
      'startDate': plan.startDate.toUtcIso8601(),
      'title': plan.title,
      'notes': plan.notes,
    };
  }

  /// Converts entity to JSON for status update.
  static Map<String, dynamic> toUpdateStatusJson(TreatmentPlanStatus status) {
    return {
      'status': status.pocketbaseValue,
    };
  }
}
