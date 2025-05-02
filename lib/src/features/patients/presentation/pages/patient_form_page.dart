import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_form_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientFormPage extends HookConsumerWidget {
  const PatientFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(patientFormControllerProvider(id));
    final selectedSpecies = useState<String?>(null);

    ref.listen(patientFormControllerProvider(id), (previous, next) {
      final patient = next.valueOrNull?.patient;
      if (patient is Patient) {
        selectedSpecies.value = patient.species;
      }
    });

    onSpeciesChange(value) {
      final fields = formKey.currentState?.fields;
      if (value == null && fields != null) {
        fields[PatientField.breed]?.reset();
        return;
      }
      if (value is! String) return;
      final formSpecies = value;
      if (selectedSpecies.value != formSpecies && fields != null) {
        fields[PatientField.breed]?.reset();
        selectedSpecies.value = formSpecies;
      }
    }

    ///
    /// Submit
    ///
    void onSave(
      Patient? patient,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patient == null
          ? repository.create(value, files: files)
          : repository.update(patient, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientTableControllerProvider);
          ref.invalidate(patientControllerProvider(r.id));
          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final patient = formState.patient;
            final branches = formState.branches;
            final images = formState.images;
            final species = formState.species;
            final sexes = formState.sexes;
            final breeds = formState.breeds
                .where((x) => x.species == selectedSpecies.value)
                .toList();

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
                /// Image
                ///
                DynamicPBImagesField(
                  name: PatientField.avatar,
                  maxFiles: 1,
                  allowCompression: false,
                  maxSizeKB: 300,
                  compressionQuality: 85,
                  previewSize: 200,
                  fieldTransformer: (list) =>
                      PBUtils.defaultFieldTransformer(list, isSingleFile: true),
                  fileTransformer: PBUtils.defaultFileTransformer,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  initialValue: images,
                  validator: FormBuilderValidators.compose([]),
                ),

                ///
                /// Patient Name
                ///
                DynamicTextField(
                  name: PatientField.name,
                  initialValue: patient?.name,
                  decoration: InputDecoration(
                    label: Text('Patient Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                DynamicFieldTwoColumn(
                  axis: Axis.vertical,
                  first: DynamicSelectField(
                    name: PatientField.species,
                    initialValue: patient?.species,
                    decoration: InputDecoration(
                      label: Text('Species'),
                      border: OutlineInputBorder(),
                    ),
                    options: species
                        .map((e) => SelectOption(
                              value: e.id,
                              display: e.name,
                            ))
                        .toList(),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    onChange: onSpeciesChange,
                  ),
                  second: DynamicSelectField(
                    name: PatientField.breed,
                    initialValue: patient?.breed,
                    decoration: InputDecoration(
                      label: Text('Breeds'),
                      border: OutlineInputBorder(),
                    ),
                    options: breeds
                        .map((e) => SelectOption(
                              value: e.id,
                              display: e.name,
                            ))
                        .toList(),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                ),
                DynamicSelectField(
                  name: PatientField.sex,
                  initialValue: patient?.sex?.name,
                  decoration: InputDecoration(
                    label: Text('Sex'),
                    border: OutlineInputBorder(),
                  ),
                  options: sexes
                      .map((e) => SelectOption(
                            value: e.name,
                            display: e.name.toProperCase(),
                          ))
                      .toList(),
                ),

                ///
                /// Owner Details
                ///
                DynamicFieldGroup(
                  padding: EdgeInsets.only(top: 20),
                  title: Text('Owner Details'),
                  fields: [
                    DynamicTextField(
                      name: PatientField.owner,
                      initialValue: patient?.owner,
                      decoration: InputDecoration(
                        label: Text('Owner Name'),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),

                DynamicFieldTwoColumn(
                  axis: Axis.vertical,
                  first: DynamicTextField(
                    name: PatientField.contactNumber,
                    initialValue: patient?.contactNumber,
                    decoration: InputDecoration(
                      label: Text('Contact Number'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  second: DynamicTextField(
                    name: PatientField.email,
                    initialValue: patient?.email,
                    decoration: InputDecoration(
                      label: Text('Owner Email'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email()
                      ],
                    ),
                  ),
                ),

                ///
                /// Branch
                ///
                DynamicFieldGroup(
                  title: Text('Other Details'),
                  padding: EdgeInsets.only(top: 20),
                  fields: [
                    DynamicSelectField(
                      name: PatientField.branch,
                      initialValue: patient?.branch ?? branches.first.id,
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
                )
              ],
              onSubmit: (result) => onSave(patient, result),
            );
          }),
    );
  }
}
