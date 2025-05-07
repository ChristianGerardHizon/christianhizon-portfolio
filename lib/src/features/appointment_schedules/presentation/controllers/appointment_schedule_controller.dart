import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_controller.g.dart';

@riverpod
class AppointmentScheduleController extends _$AppointmentScheduleController {
  @override
  Future<AppointmentSchedule> build(String id) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);
    final result = await repo
        .get(
          id,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
