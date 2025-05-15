import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/hooks/pb_empty_hook.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';

part 'appointment_schedule.mapper.dart';

@MappableEnum()
enum AppointmentScheduleStatus { scheduled, completed, missed, cancelled }

@MappableClass()
class AppointmentSchedule extends PbRecord with AppointmentScheduleMappable {
  @MappableField(hook: DateTimeHook())
  final DateTime date;
  final bool hasTime;
  final String? notes;
  final String? purpose;

  final AppointmentScheduleStatus status;

  @MappableField(hook: PbEmptyHook())
  final String? patientRecord;

  @MappableField(hook: PbEmptyHook())
  final String? patient;

  @MappableField(hook: PbEmptyHook())
  final String? patientName;

  @MappableField(hook: PbEmptyHook())
  final String? ownerName;

  @MappableField(hook: PbEmptyHook())
  final String? ownerContact;

  @MappableField(hook: PbEmptyHook())
  final String? branch;

  final AppointmentScheduleExpand expand;

  AppointmentSchedule({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    this.patientName,
    this.ownerName,
    this.ownerContact,
    this.branch,

    ///
    ///
    ///
    required this.date,
    this.patientRecord,
    this.patient,
    this.notes,
    this.purpose,
    required this.status,
    this.hasTime = false,
    required this.expand,
  });

  static const fromMap = AppointmentScheduleMapper.fromMap;
  static const fromJson = AppointmentScheduleMapper.fromJson;

  ///
  ///
  ///
  String get displayDate =>
      hasTime ? date.toLocal().fullDateTime : date.toLocal().fullDate;

  ///
  ///
  ///
  String get patientDisplayName {
    if (expand.patient != null) return expand.patient!.name;
    return patientName ?? '';
  }

  ///
  ///
  ///
  String get ownerDisplayName {
    if (expand.patient != null) return expand.patient!.name;
    return ownerName ?? '';
  }
}

@MappableClass()
class AppointmentScheduleExpand with AppointmentScheduleExpandMappable {
  final Patient? patient;
  final PatientRecord? patientRecord;
  final Branch? branch;

  AppointmentScheduleExpand({
    this.patient,
    this.patientRecord,
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AppointmentScheduleMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = AppointmentScheduleMapper.fromJson;
}
