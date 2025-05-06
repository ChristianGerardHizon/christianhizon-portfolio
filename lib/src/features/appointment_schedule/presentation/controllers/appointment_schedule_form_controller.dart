import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/appointment_schedule/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedule/domain/appointment_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_form_controller.g.dart';

class AppointmentScheduleState {
  final AppointmentSchedule? appointmentSchedule;

  AppointmentScheduleState({this.appointmentSchedule});
}

@riverpod
class AppointmentScheduleFormController
    extends _$AppointmentScheduleFormController {
  @override
  Future<AppointmentScheduleState> build(String? id) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return AppointmentScheduleState(appointmentSchedule: null);
      }
      final appointmentSchedule = await $(repo.get(id));
      return AppointmentScheduleState(appointmentSchedule: appointmentSchedule);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
