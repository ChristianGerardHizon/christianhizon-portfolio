import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/routing/router.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:gym_system/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/controllers/appointment_schedules_controller.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/widgets/appointment_schedule_card.dart';
import 'package:gym_system/src/features/appointment_schedules/presentation/widgets/appointment_schedule_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleGroup extends HookConsumerWidget {
  const AppointmentScheduleGroup({
    super.key,
    required this.patientId,
    required this.patientRecordId,
  });

  final String patientId;
  final String patientRecordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    ///
    ///
    final repo = ref.read(appointmentScheduleRepositoryProvider);

    ///
    /// state
    ///
    final state = ref.watch(appointmentSchedulesControllerProvider(
        patientId: patientId, patientRecordId: patientRecordId));

    void onAdd(String patientId, String patientRecordId) {
      AppointmentScheduleFormPageRoute(
        patientId: patientId,
        patientRecordId: patientRecordId,
      ).push(context);
    }

    return StackLoader(
      isLoading: isLoading.value,
      child: DynamicGroup(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
        header: 'Follow Up Appointment',
        headerAction: TextButton.icon(
          onPressed: () => onAdd(patientId, patientRecordId),
          icon: Icon(MIcons.plus),
          label: const Text('Add'),
        ),
        items: state.maybeWhen(
          skipLoadingOnRefresh: false,
          skipLoadingOnReload: false,
          data: (data) {
            if (data.isEmpty)
              return [
                DynamicGroupItem.widget(
                  value: const Center(
                    heightFactor: 5,
                    child: Text('No appointments found'),
                  ),
                )
              ];
            return data
                .map((e) => DynamicGroupItem.widget(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      value: AppointmentScheduleTile(
                        appointmentSchedule: e,
                        onLongPress: () {},
                        onTap: () {
                          AppointmentSchedulePageRoute(e.id).push(context);
                        },
                        onDelete: () {},
                        onChangeStatus: () {},
                        onEdit: () {},
                      ),
                    ))
                .toList();
          },
          orElse: () => [],
        ),
      ),
    );
  }
}
