import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/appointment_schedule/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedule/domain/appointment_schedule.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_controller.g.dart';

@riverpod
class AppointmentSchedulesController extends _$AppointmentSchedulesController {
  String? _buildFilter() {
    return "${AppointmentScheduleField.isDeleted} = false";
  }

  @override
  Future<List<AppointmentSchedule>> build() async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);
    final result = await repo
        .listAll(
          filter: _buildFilter(),
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
