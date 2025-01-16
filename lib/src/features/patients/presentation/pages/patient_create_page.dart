import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientCreatePage extends HookConsumerWidget {
  const PatientCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void onSubmit() async {
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

      ///
      /// separate the List<xFiles> and convert it to List<MultipartFile>
      ///
      final files = form.value[PatientField.images];

      final result =
          await ref.read(patientRepositoryProvider).create(form.value).run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          PatientsPageRoute().go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () => PatientsPageRoute().go(context),
        ),
        title: Text('Patient Create Page'),
      ),
      body: FormBuilder(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            ///
            /// Patient Details
            ///
            SliverPadding(
              padding: EdgeInsets.only(left: 10, right: 10),
              sliver: SliverList.list(
                children: [
                  SizedBox(height: 10),

                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Patient Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  SizedBox(height: 10),

                  ///
                  /// name
                  ///
                  FormBuilderTextField(
                    name: PatientField.name,
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
                  /// Species
                  ///
                  FormBuilderTextField(
                    name: PatientField.species,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Species',
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
                  /// Breed
                  ///
                  FormBuilderTypeAhead(
                    suggestionsCallback: (p0) => ['test'],
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text('test'),
                      );
                    },
                    name: PatientField.breed,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Breed',
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
                  /// Color
                  ///
                  FormBuilderTextField(
                    name: PatientField.color,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Color',
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
                  /// Sex
                  ///
                  FormBuilderDropdown<String>(
                    name: PatientField.sex,
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
                  /// Date Of Birth
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
                ],
              ),
            ),

            ///
            /// Owner Details
            ///
            SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                sliver: SliverList.list(children: [
                  ///
                  ///
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
                  /// address
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
                  /// ContactNumber
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
                ])),

            ///
            /// Save Button
            ///
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 30, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading.value,
                  child: Text('Save'),
                  onPressed: onSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
