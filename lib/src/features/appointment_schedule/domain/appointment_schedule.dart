import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';

part 'appointment_schedule.mapper.dart';

@MappableClass()
class AppointmentSchedule extends PbRecord with AppointmentScheduleMappable {
  @MappableField(hook: DateTimeHook())
  final DateTime date;
  final bool hasTime;
  final bool isCompleted;
  final String? purpose;

  AppointmentSchedule({
    required super.id,
    required super.collectionId,
    required super.collectionName,

    ///
    ///
    ///
    required this.date,
    this.purpose,
    this.isCompleted = false,
    this.hasTime = false,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static const fromMap = AppointmentScheduleMapper.fromMap;
  static const fromJson = AppointmentScheduleMapper.fromJson;
}
