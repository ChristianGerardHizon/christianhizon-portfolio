import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/strings/table_controller_keys.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/features/patients/breeds/data/patient_breed_repository.dart';
import 'package:sannjosevet/src/features/patients/breeds/domain/patient_breed.dart';
import 'package:sannjosevet/src/features/patients/breeds/presentation/controllers/patient_breed_form_controller.dart';
import 'package:sannjosevet/src/features/patients/breeds/presentation/controllers/patient_breed_table_controller.dart';
import 'package:sannjosevet/src/features/patients/species/domain/patient_species.dart';
import 'package:sannjosevet/src/features/patients/species/presentation/widgets/patient_species_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientBreedFormPage extends HookConsumerWidget {
  const PatientBreedFormPage({super.key, this.id, required this.parentId});

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(
        patientBreedFormControllerProvider(id, patientSpeciesId: parentId));

    ///
    /// Submit
    ///
    void onSave(
      PatientBreed? patientBreed,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientBreedRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientBreed == null
          ? repository.create(value, files: files)
          : repository.update(patientBreed, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientBreedTableControllerProvider(
            TableControllerKeys.patientBreed,
            patientSpeciesId: parentId,
          ));
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
            final patientBreed = formState.patientBreed;
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
                /// Patient
                ///
                if (patientSpecies is PatientSpecies)
                  DynamicViewField(
                    name: PatientBreedField.species,
                    initialValue: patientSpecies,
                    decoration: InputDecoration(
                      label: Text('Species'),
                      border: OutlineInputBorder(),
                    ),
                    builder: (obj) {
                      if (obj is PatientSpecies) {
                        return PatientSpeciesTile(patientSpecies: obj);
                      }
                      return const SizedBox();
                    },
                    valueTransformer: (patientSpecies) {
                      return patientSpecies?.id;
                    },
                  ),

                ///
                /// Names
                ///
                DynamicTextField(
                  name: PatientBreedField.name,
                  initialValue: patientBreed?.name,
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
              onSubmit: (result) => onSave(patientBreed, result),
            );
          }),
    );
  }
}
