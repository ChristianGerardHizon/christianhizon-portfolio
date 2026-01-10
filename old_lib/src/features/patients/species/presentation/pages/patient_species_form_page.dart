import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/features/patients/species/data/patient_species_repository.dart';
import 'package:sannjosevet/src/features/patients/species/domain/patient_species.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/controllers/patient_species_form_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientSpeciesFormPage extends HookConsumerWidget {
  const PatientSpeciesFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(patientSpeciesFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      PatientSpecies? patientSpecies,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientSpeciesRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientSpecies == null
          ? repository.create(value, files: files)
          : repository.update(patientSpecies, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Species Form'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final patientSpecies = formState.patientSpecies;
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
                /// Notes
                ///
                DynamicTextField(
                  name: PatientSpeciesField.name,
                  initialValue: patientSpecies?.name,
                  decoration: InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ],
              onSubmit: (result) => onSave(patientSpecies, result),
            );
          }),
    );
  }
}
