import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:gym_system/src/features/patient_prescription_items/presentation/controllers/patient_prescription_item_form_controller.dart';
import 'package:gym_system/src/features/patient_prescription_items/presentation/controllers/patient_prescription_item_group_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientPrescriptionItemFormPage extends HookConsumerWidget {
  const PatientPrescriptionItemFormPage(
      {super.key, this.id, required this.parentId});

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(patientPrescriptionItemFormControllerProvider(
      parentId: parentId,
      id: id,
    ));

    ///
    /// Submit
    ///
    void onSave(
      PatientPrescriptionItem? patientPrescriptionItem,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientPrescriptionItemRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientPrescriptionItem == null
          ? repository.create(value, files: files)
          : repository.update(patientPrescriptionItem, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(
              patientPrescriptionItemGroupControllerProvider(parentId));
          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient PrescriptionItem Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final patientPrescriptionItem = formState.patientPrescriptionItem;
            final patientRecord = formState.patientRecord;
            return DynamicFormBuilder(
              onChange: (value) {},
              itemPadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 0,
              ),
              formKey: formKey,
              isLoading: isLoading.value,
              fields: [
                ///
                /// Patient Record
                ///
                DynamicHiddenField(
                  name: PatientPrescriptionItemField.patientRecord,
                  initialValue: patientRecord.id,
                ),

                ///
                /// Prescription Date
                ///
                DynamicDateField(
                  name: PatientPrescriptionItemField.date,
                  initialValue: patientPrescriptionItem?.date ?? DateTime.now(),
                  decoration: InputDecoration(
                    label: Text('Date'),
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

                ///
                /// Medication
                ///
                DynamicTextField(
                  name: PatientPrescriptionItemField.medication,
                  initialValue: patientPrescriptionItem?.medication,
                  decoration: InputDecoration(
                    label: Text('Medication'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Dosage
                ///
                DynamicTextField(
                  name: PatientPrescriptionItemField.dosage,
                  initialValue: patientPrescriptionItem?.dosage,
                  decoration: InputDecoration(
                    label: Text('Dosage'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Instructions
                ///
                DynamicTextField(
                  name: PatientPrescriptionItemField.instructions,
                  initialValue: patientPrescriptionItem?.instructions,
                  decoration: InputDecoration(
                    label: Text('Instructions'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),
              ],
              onSubmit: (result) => onSave(patientPrescriptionItem, result),
            );
          }),
    );
  }
}
