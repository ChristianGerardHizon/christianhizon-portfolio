import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';
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
  final String? patientRecord;

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
    this.purpose,
    required this.status,
    this.hasTime = false,
    required this.expand,
  });

  static const fromMap = AppointmentScheduleMapper.fromMap;
  static const fromJson = AppointmentScheduleMapper.fromJson;
}

@MappableClass()
class AppointmentScheduleExpand with AppointmentScheduleExpandMappable {
  final Patient? patient;

  AppointmentScheduleExpand({
    this.patient,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AppointmentScheduleMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = AppointmentScheduleMapper.fromJson;
}
