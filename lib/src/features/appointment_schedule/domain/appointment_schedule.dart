import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'appointment_schedule.mapper.dart';

@MappableClass()
class AppointmentSchedule extends PbRecord with AppointmentScheduleMappable {
  final DateTime date;
  final bool hasTime;

  AppointmentSchedule({
    required super.id,
    required super.collectionId,
    required super.collectionName,


    /// 
    /// 
    /// 
    required this.date,
     this.hasTime = false,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static const fromMap = AppointmentScheduleMapper.fromMap;
  static const fromJson = AppointmentScheduleMapper.fromJson;
}
