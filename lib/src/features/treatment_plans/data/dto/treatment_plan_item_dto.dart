import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../appointments/data/dto/appointment_schedule_dto.dart';
import '../../../appointments/domain/appointment_schedule.dart';
import '../../domain/treatment_plan_item.dart';
import '../../domain/treatment_plan_item_status.dart';

part 'treatment_plan_item_dto.mapper.dart';

/// Data Transfer Object for TreatmentPlanItem from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain TreatmentPlanItem.
@MappableClass()
class TreatmentPlanItemDto with TreatmentPlanItemDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String plan;
  final int sequence;
  final String expectedDate;
  final String status;
  final String? appointment;
  final String? completedDate;
  final String? notes;
  final bool isDeleted;
  final String? created;
  final String? updated;

  // Expanded appointment data
  final AppointmentSchedule? expandedAppointment;

  // Expanded plan data (patient and treatment names)
  final String? patientName;
  final String? treatmentName;

  const TreatmentPlanItemDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.plan,
    required this.sequence,
    required this.expectedDate,
    required this.status,
    this.appointment,
    this.completedDate,
    this.notes,
    this.isDeleted = false,
    this.created,
    this.updated,
    this.expandedAppointment,
    this.patientName,
    this.treatmentName,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory TreatmentPlanItemDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Handle expanded appointment relation
    AppointmentSchedule? expandedAppointment;
    String? patientName;
    String? treatmentName;

    final expand = json['expand'] as Map<String, dynamic>?;
    if (expand != null) {
      // Parse expanded appointment
      if (expand['appointment'] != null) {
        final appointmentExpand = expand['appointment'] as Map<String, dynamic>;
        final appointmentRecord = RecordModel.fromJson(appointmentExpand);
        expandedAppointment =
            AppointmentScheduleDto.fromRecord(appointmentRecord).toEntity();
      }

      // Parse expanded plan with patient and treatment
      if (expand['plan'] != null) {
        final planExpand = expand['plan'] as Map<String, dynamic>;
        final planExpandNested = planExpand['expand'] as Map<String, dynamic>?;

        if (planExpandNested != null) {
          // Get patient name
          if (planExpandNested['patient'] != null) {
            final patientExpand =
                planExpandNested['patient'] as Map<String, dynamic>;
            patientName = patientExpand['name'] as String?;
          }

          // Get treatment name
          if (planExpandNested['treatment'] != null) {
            final treatmentExpand =
                planExpandNested['treatment'] as Map<String, dynamic>;
            treatmentName = treatmentExpand['name'] as String?;
          }
        }
      }
    }

    return TreatmentPlanItemDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      plan: json['plan'] as String? ?? '',
      sequence: json['sequence'] as int? ?? 1,
      expectedDate: json['expectedDate'] as String? ?? '',
      status: json['status'] as String? ?? 'scheduled',
      appointment: json['appointment'] is String ? json['appointment'] as String : null,
      completedDate: json['completedDate'] is String ? json['completedDate'] as String : null,
      notes: json['notes'] is String ? json['notes'] as String : null,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      expandedAppointment: expandedAppointment,
      patientName: patientName,
      treatmentName: treatmentName,
    );
  }

  /// Converts the DTO to a domain TreatmentPlanItem entity.
  TreatmentPlanItem toEntity() {
    return TreatmentPlanItem(
      id: id,
      planId: plan,
      sequence: sequence,
      expectedDate: parseToLocalOrDefault(expectedDate, DateTime.now()),
      status: TreatmentPlanItemStatusX.fromPocketbaseValue(status),
      appointmentId: appointment,
      appointment: expandedAppointment,
      completedDate: parseToLocal(completedDate),
      notes: notes,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
      patientName: patientName,
      treatmentName: treatmentName,
    );
  }

  /// Converts entity to JSON for create/update operations.
  static Map<String, dynamic> toCreateJson(TreatmentPlanItem item) {
    return {
      'plan': item.planId,
      'sequence': item.sequence,
      'expectedDate': item.expectedDate.toUtcIso8601(),
      'status': item.status.pocketbaseValue,
      'appointment': item.appointmentId,
      'completedDate': item.completedDate?.toUtcIso8601(),
      'notes': item.notes,
    };
  }

  /// Converts entity to JSON for update operations (status change).
  static Map<String, dynamic> toUpdateStatusJson(
    TreatmentPlanItemStatus status, {
    DateTime? completedDate,
  }) {
    final json = <String, dynamic>{
      'status': status.pocketbaseValue,
    };
    if (completedDate != null) {
      json['completedDate'] = completedDate.toUtcIso8601();
    }
    return json;
  }

  /// Converts entity to JSON for linking an appointment.
  static Map<String, dynamic> toLinkAppointmentJson(
    String appointmentId,
    TreatmentPlanItemStatus status,
  ) {
    return {
      'appointment': appointmentId,
      'status': status.pocketbaseValue,
    };
  }
}
