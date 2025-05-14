import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/hooks/pb_empty_hook.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';
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
  final String? purpose;
  final AppointmentScheduleStatus status;
  @MappableField(hook: PbEmptyHook())
  final String? patientRecord;
  @MappableField(hook: PbEmptyHook())
  final String? patient;

  final AppointmentScheduleExpand expand;

  AppointmentSchedule({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,

    ///
    ///
    ///
    required this.date,
    this.patientRecord,
    this.patient,
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
}

@MappableClass()
class AppointmentScheduleExpand with AppointmentScheduleExpandMappable {
  final Patient? patient;
  final PatientRecord? patientRecord;

  AppointmentScheduleExpand({
    this.patient,
    this.patientRecord,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AppointmentScheduleMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = AppointmentScheduleMapper.fromJson;
}
