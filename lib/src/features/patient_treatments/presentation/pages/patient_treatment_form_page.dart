import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/features/patient_treatments/data/patient_treatment_repository.dart';
import 'package:sannjosevet/src/features/patient_treatments/domain/patient_treatment.dart';
import 'package:sannjosevet/src/features/patient_treatments/presentation/controllers/patient_treatment_form_controller.dart';
import 'package:sannjosevet/src/features/patient_treatments/presentation/controllers/patient_treatment_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentFormPage extends HookConsumerWidget {
  const PatientTreatmentFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = patientTreatmentFormControllerProvider(id);
    final state = ref.watch(provider);
    final tableKey = TableControllerKeys.patientTreatment;
    final tableProvider = patientTreatmentTableControllerProvider(tableKey);

    ///
    /// Submit
    ///
    void onSave(
      PatientTreatment? patientTreatment,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientTreatmentRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientTreatment == null
          ? repository.create(value, files: files)
          : repository.update(patientTreatment, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(tableProvider);
          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient PrescriptionItem Form Page'),
      ),
      body: state.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Form Error')),
          data: (formState) {
            final treatment = formState.projectTreatment;

            return Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: DynamicFormBuilder(
                formKey: formKey,
                isLoading: isLoading.value,
                fields: [
                  DynamicTextField(
                      name: PatientTreatmentField.name,
                      initialValue: treatment?.name,
                      decoration: const InputDecoration(
                          label: Text('Name'), border: OutlineInputBorder())),
                ],
                onSubmit: (result) => onSave(treatment, result),
              ),
            );
          }),
    );
  }
}
