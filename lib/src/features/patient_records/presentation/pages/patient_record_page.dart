import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_group/dynamic_group_item.dart';
import 'package:sannjosevet/src/core/widgets/modals/confirm_modal.dart';
import 'package:sannjosevet/src/core/widgets/failure_message.dart';
import 'package:sannjosevet/src/core/widgets/stack_loader.dart';
import 'package:sannjosevet/src/features/appointment_schedules/presentation/widgets/appointment_schedule_group.dart';
import 'package:sannjosevet/src/features/patient_prescription_items/presentation/widgets/patient_prescription_items_group.dart';
import 'package:sannjosevet/src/features/patient_records/data/patient_record_repository.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_page_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PatientRecordPage extends HookConsumerWidget {
  const PatientRecordPage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    /// loading variable
    ///
    final isLoading = useState(false);

    ///
    /// repo
    ///
    final repo = ref.read(patientRecordRepositoryProvider);

    ///
    ///
    ///
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    ///
    /// refresh
    ///
    refresh(String id) {
      // ref.invalidate(patientRecordControllerProvider(id));
      // ref.invalidate(patientRecordTableControllerProvider);
      // ref.invalidate(patientRecordControllerProvider(id));
      // formKey.currentState?.reset();
    }

    ///
    /// onDelete
    ///
    onDelete(PatientRecord patientRecord) async {
      final fullTask = await
          // 1. Call Confirm Modal
          ConfirmModal.taskResult(context)

              /// start loading
              .flatMap((_) {
                isLoading.value = true;
                return TaskResult.right(_);
              })
              // 2. Delete Network Call
              .flatMap((_) => repo.softDeleteMulti([patientRecord.id]))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulDeleteTaskSidEffects(
                  context: context,
                  patientRecordId: patientRecord.id,
                  refresh: refresh,
                ),
              );

      final result = await fullTask.run();
      isLoading.value = false;

      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    formChanged(PatientRecord patientRecord) async {
      final fullTask = await
          // 1. Get Form Data
          ConfirmModal.taskResult(context)

              // start loading
              .flatMap((_) {
                isLoading.value = true;
                return TaskResult.right(_);
              })
              .flatMap((data) => getFormData(formKey))
              // 2. Update record
              .flatMap((data) => repo.update(patientRecord, data))
              // 3. Side effects
              .flatMap(
                (_) => _handleSuccessfulSaveTaskSidEffects(
                  context: context,
                  patientRecordId: patientRecord.id,
                  refresh: refresh,
                ),
              );

      final result = await fullTask.run();
      isLoading.value = false;
      // 4. Handle Error
      result.match(
        (failure) => _handleFailure(context, failure),
        (_) {},
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Record Details'),
        actions: [],
      ),
      body: ref.watch(patientRecordPageControllerProvider(id)).when(
            skipError: false,
            skipLoadingOnRefresh: false,
            skipLoadingOnReload: false,
            error: (error, stack) => FailureMessage(error, stack),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (patientRecordState) {
              final patientRecord = patientRecordState.patientRecord;
              // final patient = patientRecordState.patient;
              return FormBuilder(
                key: formKey,
                enabled: !isLoading.value,
                initialValue: {
                  PatientRecordField.diagnosis: patientRecord.diagnosis,
                  PatientRecordField.treatment: patientRecord.treatment,
                  PatientRecordField.notes: patientRecord.notes,
                  PatientRecordField.vistDate:
                      patientRecord.visitDate.toLocal(),
                  PatientRecordField.tests: patientRecord.tests,
                  PatientRecordField.weightInKg:
                      patientRecord.weightInKg?.toString(),
                },
                child: StackLoader(
                  isLoading: isLoading.value,
                  child: CustomScrollView(
                    slivers: [
                      ///
                      /// Content
                      ///
                      SliverList.list(
                        children: [
                          SizedBox(height: 20),

                          ///
                          /// Diagnosis
                          ///
                          DynamicGroup(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 12),
                            header: 'Record Information',
                            headerAction: TextButton.icon(
                              label: const Text('Save Changes'),
                              onPressed: () => formChanged(patientRecord),
                              icon: Icon(Icons.save),
                            ),
                            items: [
                              DynamicGroupItem.field(
                                title: 'Visit Date',
                                value: FormBuilderDateTimePicker(
                                  barrierDismissible: true,
                                  timePickerInitialEntryMode:
                                      TimePickerEntryMode.input,
                                  format: DateFormat('MMM d, yyyy h:mm a'),
                                  name: PatientRecordField.vistDate,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
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
                              ),
                              DynamicGroupItem.field(
                                title: 'Tests Done',
                                value: FormBuilderTextField(
                                  name: PatientRecordField.tests,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  minLines: 3,
                                  maxLines: 10,
                                ),
                              ),
                              DynamicGroupItem.field(
                                title: 'Diagnosis',
                                value: FormBuilderTextField(
                                  name: PatientRecordField.diagnosis,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  minLines: 3,
                                  maxLines: 10,
                                ),
                              ),
                              DynamicGroupItem.field(
                                title: 'Treatment',
                                value: FormBuilderTextField(
                                  name: PatientRecordField.treatment,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  minLines: 3,
                                  maxLines: 10,
                                ),
                              ),
                              DynamicGroupItem.field(
                                title: 'Weight in Kg',
                                value: FormBuilderTextField(
                                  name: PatientRecordField.weightInKg,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*$')),
                                  ],
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                    FormBuilderValidators.numeric(),
                                  ]),
                                  valueTransformer: (value) {
                                    if (value is String) {
                                      return num.parse(value);
                                    }
                                  },
                                ),
                              ),
                              DynamicGroupItem.field(
                                title: 'Notes',
                                value: FormBuilderTextField(
                                  name: PatientRecordField.notes,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  minLines: 3,
                                  maxLines: 10,
                                ),
                              ),
                            ],
                          ),

                          ///
                          /// Prescriptions
                          ///
                          PatientPrescriptionItemsGroup(
                            patient: patientRecordState.patient,
                            record: patientRecord,
                          ),

                          AppointmentScheduleGroup(
                            patientId: patientRecordState.patient.id,
                            patientRecordId: patientRecord.id,
                          ),

                          ///
                          /// Actions
                          ///
                          DynamicGroup(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 12),
                            header: 'Actions',
                            items: [
                              DynamicGroupItem.action(
                                titleColor: Theme.of(context).colorScheme.error,
                                onTap: () => onDelete(patientRecord),
                                leading: Icon(
                                  MIcons.trashCan,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                title: 'Delete Record',
                                trailing: Icon(MIcons.chevronRight),
                              ),
                            ],
                          ),

                          ///
                          /// Spacer
                          ///
                          SizedBox(height: 50),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}

TaskResult<Map<String, dynamic>> getFormData(
    GlobalKey<FormBuilderState> formKey) {
  return TaskResult<Map<String, dynamic>>.tryCatch(() async {
    final state = formKey.currentState;
    if (state == null) throw PresentationFailure('form is null');
    if (state.saveAndValidate() != true)
      throw PresentationFailure('form is invalid');
    ();
    return state.instantValue;
  }, (error, stackTrace) {
    return Failure.handle(error, stackTrace);
  });
}

///
/// Handles post-delete side effects like showing snackbar,
/// popping navigation, and refreshing local state.
///
TaskResult<void> _handleSuccessfulDeleteTaskSidEffects({
  required BuildContext context,
  required String patientRecordId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Deleted');
    if (context.canPop()) context.pop();
    refresh(patientRecordId);
    return null;
  }).toTaskEither<Failure>();
}

TaskResult<void> _handleSuccessfulSaveTaskSidEffects({
  required BuildContext context,
  required String patientRecordId,
  required void Function(String id) refresh,
}) {
  return Task<void>(() async {
    if (!context.mounted) return;
    AppSnackBar.root(message: 'Successfully Saved');
    refresh(patientRecordId);
    return null;
  }).toTaskEither<Failure>();
}

///
/// Handles Failure
/// Shows a snackbar when a failure occurs
///
void _handleFailure(BuildContext context, Failure failure) {
  if (failure is CancelledFailure) return;
  AppSnackBar.rootFailure(failure);
}
