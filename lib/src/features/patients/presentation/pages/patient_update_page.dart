import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/file_picker.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/core/widgets/responsive_two_fields.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patients/patient_update_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/breeds/patient_breed_form_field.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_image_control_widget.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/species/patient_species_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientUpdatePage extends HookConsumerWidget {
  const PatientUpdatePage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateController = patientUpdateControllerProvider(id);
    final state = ref.watch(updateController);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final provider = patientControllerProvider(id);

    onRefresh() {
      ref.invalidate(updateController);
      ref.invalidate(provider);
    }

    ///
    /// onUpload
    ///
    onUpload(Patient patient) async {
      final repo = ref.read(patientRepositoryProvider);

      final result = await TaskResult<Patient?>.Do(($) async {
        final images = await $(
          FilePickerUtil.getImage(PatientField.avatar),
        );
        if (images == null || images.isEmpty) return $(TaskResult.right(null));
        return $(repo.update(patient, {}, files: images));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        onRefresh();
        AppSnackBar.root(message: 'Successfully Updated');
      });
    }

    ///
    /// onImageDiscard
    ///
    onImageDiscard(Patient patient) async {
      final repo = ref.read(patientRepositoryProvider);

      final confirm = await ConfirmModal.show(context);
      if (confirm != true) return;

      final result = await TaskResult<Patient?>.Do(($) async {
        return $(repo.update(patient, {PatientField.avatar: null}));
      }).run();

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          if (r == null) return;
          onRefresh();
          AppSnackBar.root(message: 'Successfully Delete Image');
        },
      );
    }

    void onSubmit(Patient patient) async {
      isLoading.value = true;
      final form = formKey.currentState;
      if (form == null) {
        isLoading.value = false;
        return;
      }
      final isValid = form.saveAndValidate();
      if (!isValid) {
        isLoading.value = false;
        return;
      }

      final values = form.instantValue;

      final result = await ref
          .read(patientRepositoryProvider)
          .update(patient, values)
          .run();

      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          ref.invalidate(patientControllerProvider(id));
          if (context.canPop()) context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Update Page'),
        actions: [
          IconButton(
            onPressed: onRefresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        skipError: false,
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => CenteredProgressIndicator(),
        data: (updateState) {
          final patient = updateState.patient;
          // final settings = updateState.settings;
          final map = patient.toForm();
          return FormBuilder(
            key: formKey,
            initialValue: map,
            child: CustomScrollView(
              slivers: [
                ///
                /// image
                ///
                SliverToBoxAdapter(
                  child: PatientImageControlWidget(
                    patient: patient,
                    onUpload: () => onUpload(patient),
                    onImageDiscard: () => onImageDiscard(patient),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                  sliver: SliverList.list(children: [
                    SizedBox(height: 10),

                    ///
                    /// name
                    ///
                    FormBuilderTextField(
                      name: PatientField.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Patient Name',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    ///
                    /// Species and Breed
                    ///
                    ResponsiveTwoFields(
                      verticalGap: 10,
                      horizontalGap: 10,
                      children: [
                        ///
                        /// Species
                        ///
                        PatientSpeciesFormField(
                          list: updateState.species,
                          name: PatientField.species,
                        ),

                        ///
                        /// Breeds
                        ///
                        PatientBreedFormField(
                          list: updateState.breeds,
                          name: PatientField.breed,
                        )
                      ],
                    ),

                    SizedBox(height: 10),

                    ///
                    /// Sex
                    ///
                    FormBuilderDropdown<String>(
                      name: PatientField.sex,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Sex',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: ['male', 'female']
                          .map((sex) => DropdownMenuItem(
                                value: sex,
                                child: Text(sex),
                              ))
                          .toList(),
                    ),

                    SizedBox(height: 10),

                    ///
                    /// Date of Birth
                    ///
                    FormBuilderDateTimePicker(
                      initialEntryMode: DatePickerEntryMode.inputOnly,
                      inputType: InputType.date,
                      name: PatientField.dateOfBirth,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Date of Birth',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      valueTransformer: (dateTime) {
                        if (dateTime == null) return null;
                        return dateTime.toUtc().toIso8601String();
                      },
                    ),
                  ]),
                ),

                ///
                /// Owner Details
                ///
                SliverPadding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                    sliver: SliverList.list(children: [
                      ///
                      /// Header
                      ///
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          'Owner Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      SizedBox(height: 10),

                      ///
                      /// Owner
                      ///
                      FormBuilderTextField(
                        name: PatientField.owner,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 10, right: 8, left: 8, top: 30),
                          labelText: 'Owner',
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      ///
                      /// Address
                      ///
                      FormBuilderTextField(
                        name: PatientField.address,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 10, right: 8, left: 8, top: 30),
                          labelText: 'Address',
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      ///
                      /// Contact Number
                      ///
                      FormBuilderTextField(
                        name: PatientField.contactNumber,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 10, right: 8, left: 8, top: 30),
                          labelText: 'Contact Number',
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      ///
                      /// Email
                      ///
                      FormBuilderTextField(
                        name: PatientField.email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: 10, right: 8, left: 8, top: 30),
                          labelText: 'Email',
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ])),

                ///
                /// Save button
                ///
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: LoadingFilledButton(
                        isLoading: isLoading.value,
                        child: Text('Save'),
                        onPressed: () => onSubmit(patient),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20))
              ],
            ),
          );
        },
      ),
    );
  }
}
