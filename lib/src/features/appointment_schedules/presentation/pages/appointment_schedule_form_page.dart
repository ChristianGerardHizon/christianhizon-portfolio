import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/controllers/appointment_schedule_form_controller.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/controllers/appointment_schedule_table_controller.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/widgets/patient_record_tile.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/presentation/widgets/patient_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentScheduleFormPage extends HookConsumerWidget {
  const AppointmentScheduleFormPage({
    super.key,
    this.id,
    this.patientId,
    this.patientRecordId,
  });

  final String? id;
  final String? patientId;
  final String? patientRecordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = appointmentScheduleFormControllerProvider(
      id,
      patientId: patientId,
      patientRecordId: patientRecordId,
    );
    final state = ref.watch(provider);
    final hasTime = useState(false);

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
          context.pop(r);
        },
      );
    }

    ref.listen(provider, (prev, next) {
      final hasNext = next.value?.appointmentSchedule?.hasTime;
      if (hasNext is bool) {
        hasTime.value = hasNext;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('AppointmentSchedule Form'),
      ),
      body: state.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => FailureMessage.asyncValue(state),
          data: (formState) {
            final appointmentSchedule = formState.appointmentSchedule;
            final patient = formState.patient;
            final patientRecord = formState.patientRecord;
            final branches = formState.branches;

            return Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: DynamicFormBuilder(
                formKey: formKey,
                isLoading: isLoading.value,
                itemPadding: const EdgeInsets.only(top: 14),
                fields: [
                  ///
                  /// Patient
                  ///
                  if (patient is Patient)
                    DynamicViewField(
                      name: AppointmentScheduleField.patient,
                      initialValue: patient,
                      decoration: InputDecoration(
                        label: Text('Patient'),
                        border: OutlineInputBorder(),
                      ),
                      builder: (obj) {
                        if (obj is Patient) {
                          return PatientTile(patient: obj);
                        }
                        return const SizedBox();
                      },
                      valueTransformer: (patient) {
                        return patient?.id;
                      },
                    ),

                  ///
                  /// Patient Record
                  ///
                  if (patientRecord is PatientRecord)
                    DynamicViewField(
                      name: AppointmentScheduleField.patientRecord,
                      initialValue: patientRecord,
                      decoration: InputDecoration(
                        label: Text('Patient Record'),
                        border: OutlineInputBorder(),
                      ),
                      builder: (obj) {
                        if (obj is PatientRecord) {
                          return PatientRecordTile(patientRecord: obj);
                        }
                        return const SizedBox();
                      },
                      valueTransformer: (patient) {
                        return patient?.id;
                      },
                    ),

                  DynamicCheckboxField(
                    name: AppointmentScheduleField.hasTime,
                    initialValue: hasTime.value,
                    title: 'Has Time',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      helperText:
                          'When checked, the date field will be a date and time field',
                    ),
                    valueTransformer: (p0) => hasTime.value = p0 as bool,
                    onChange: (p0) {
                      hasTime.value = p0 as bool;
                      final value = formKey
                          .currentState?.fields[AppointmentScheduleField.date];
                      if (value != null) {
                        value.didChange(null);
                      }
                    },
                  ),
                  hasTime.value
                      ? DynamicDateTimeField(
                          name: AppointmentScheduleField.date,
                          initialValue: appointmentSchedule?.date.toLocal(),
                          decoration: InputDecoration(
                            label: Text('Appointment Date and Time'),
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
                        )
                      : DynamicDateField(
                          name: AppointmentScheduleField.date,
                          initialValue: appointmentSchedule?.date,
                          decoration: InputDecoration(
                            label: Text('Appointment Date'),
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
                  if (id is String)
                    DynamicSelectField(
                      name: AppointmentScheduleField.status,
                      initialValue: appointmentSchedule?.status.name ??
                          AppointmentScheduleStatus.scheduled.name,
                      options: AppointmentScheduleStatus.values
                          .map(
                            (e) => SelectOption(
                              value: e.name,
                              display: e.name,
                            ),
                          )
                          .toList(),
                      decoration: InputDecoration(
                        label: Text('Status'),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  if (id is! String)
                    DynamicHiddenField(
                      name: AppointmentScheduleField.status,
                      initialValue: AppointmentScheduleStatus.scheduled.name,
                    ),

                  if (patient is! Patient) ...[
                    DynamicTextField(
                      name: AppointmentScheduleField.patientName,
                      initialValue: appointmentSchedule?.patientName,
                      decoration: const InputDecoration(
                        label: Text('Patient/Owner Name'),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    DynamicTextField(
                      name: AppointmentScheduleField.ownerName,
                      initialValue: appointmentSchedule?.ownerName,
                      decoration: const InputDecoration(
                        label: Text('Owner Name'),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    DynamicTextField(
                      name: AppointmentScheduleField.ownerContact,
                      initialValue: appointmentSchedule?.ownerContact,
                      decoration: const InputDecoration(
                        label: Text('Owner Contact'),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ],
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
                  DynamicTextField(
                    name: AppointmentScheduleField.notes,
                    initialValue: appointmentSchedule?.notes,
                    decoration: const InputDecoration(
                      label: Text('Notes'),
                      border: OutlineInputBorder(),
                    ),
                    minLines: 3,
                    maxLines: 10,
                    validator: FormBuilderValidators.compose([]),
                  ),

                  ///
                  /// Branches
                  ///
                  DynamicSelectField(
                    name: PatientRecordField.branch,
                    initialValue:
                        appointmentSchedule?.branch ?? branches.firstOrNull?.id,
                    decoration: InputDecoration(
                      label: Text('Branch'),
                      border: OutlineInputBorder(),
                    ),
                    options: branches
                        .map((e) => SelectOption(
                              value: e.id,
                              display: e.name,
                            ))
                        .toList(),
                  ),
                ],
                onSubmit: (result) => onSave(appointmentSchedule, result),
              ),
            );
          }),
    );
  }
}
