import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/appointment_schedule/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedule/domain/appointment_schedule.dart';
import 'package:gym_system/src/features/appointment_schedule/presentation/controllers/appointment_schedule_form_controller.dart';
import 'package:gym_system/src/features/appointment_schedule/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleFormPage extends HookConsumerWidget {
  const AppointmentScheduleFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(appointmentScheduleFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      AppointmentSchedule? appointmentSchedule,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(appointmentScheduleRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (appointmentSchedule == null
          ? repository.create(value, files: files)
          : repository.update(appointmentSchedule, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(appointmentScheduleTableControllerProvider);
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('AppointmentSchedule Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Form Error')),
          data: (formState) {
            final appointmentSchedule = formState.appointmentSchedule;

            return Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: DynamicFormBuilder(
                formKey: formKey,
                isLoading: isLoading.value,
                itemPadding: const EdgeInsets.only(top: 14),
                fields: [
                  DynamicDateTimeField(
                    name: PatientRecordField.vistDate,
                    initialValue: appointmentSchedule?.date,
                    decoration: InputDecoration(
                      label: Text('Visit Date and Time'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    valueTransformer: (p0) {
                      final value = p0;
                      if (value is DateTime)
                        return value.toUtc().toIso8601String();
                    },
                  ),
                  DynamicTextField(
                    name: AppointmentScheduleField.purpose,
                    initialValue: appointmentSchedule?.purpose,
                    decoration: const InputDecoration(
                      label: Text('Purpose'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                ],
                onSubmit: (result) => onSave(appointmentSchedule, result),
              ),
            );
          }),
    );
  }
}
