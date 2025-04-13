import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/form_builders/hidden_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/domain/patient_treatment.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/treatment_record/patient_treatment_record_page_controller.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/data/treatment_record/patient_treatment_record_repository.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/treatment/treatment_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PatientTreatmentRecordCreateSheet extends HookConsumerWidget {
  final PatientTreatment? treatment;
  final Patient patient;

  final Map<String, dynamic>? formData;

  const PatientTreatmentRecordCreateSheet({
    super.key,
    required this.treatment,
    required this.patient,
    this.formData,
  });

  static Future show(
    BuildContext context, {
    PatientTreatment? treatment,
    required Patient patient,
    Map<String, dynamic>? formData,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) => PatientTreatmentRecordCreateSheet(
          patient: patient, treatment: treatment, formData: formData),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final isFullScreen = useState(false);

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

      final result = await ref
          .read(treatmentRecordRepositoryProvider)
          .create(form.value)
          .run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientTreatmentRecordsPageControllerProvider);
          context.pop(r);
        },
      );
    }

    final content = Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        child: FormBuilder(
          key: formKey,
          initialValue: {
            PatientTreatmentRecordField.id:
                formData?[PatientTreatmentRecordField.id],
            PatientTreatmentRecordField.date:
                formData?[PatientTreatmentRecordField.date] ?? DateTime.now(),
            PatientTreatmentRecordField.patient:
                formData?[PatientTreatmentRecordField.patient] ?? patient,
            PatientTreatmentRecordField.type:
                formData?[PatientTreatmentRecordField.type] ?? treatment,
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: CloseButton(),
                title: Text('New PatientTreatment Record'),
              ),

              ///
              /// Date
              ///
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'PatientTreatment Date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: PatientTreatmentRecordField.date,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      valueTransformer: (value) => value?.toIso8601String(),
                      firstDate:
                          DateTime.now().subtract(Duration(days: 365 * 5)),
                      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      format: DateFormat('yyyy-MM-dd'),
                      initialTime: TimeOfDay(hour: 0, minute: 0),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Date',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Type of PatientTreatment',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    TreatmentFormField(
                      readOnly: false,
                      name: PatientTreatmentRecordField.type,
                      valueTransformer: (x) => x.id,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 10),
                    HiddenFormField(
                      name: PatientTreatmentRecordField.patient,
                      valueTransformer: (x) => x.id,
                    ),
                  ],
                ),
              ),

              ///
              /// Fields
              ///
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Follow Up Date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 4),
                    FormBuilderDateTimePicker(
                      name: PatientTreatmentRecordField.followUpDate,
                      initialEntryMode: DatePickerEntryMode.calendar,
                      valueTransformer: (value) => value?.toIso8601String(),
                      firstDate:
                          DateTime.now().subtract(Duration(days: 365 * 5)),
                      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      format: DateFormat('yyyy-MM-dd'),
                      initialTime: TimeOfDay(hour: 0, minute: 0),
                      inputType: InputType.date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: PatientTreatmentRecordField.note,
                      maxLines: 10,
                      minLines: 3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Note',
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///
              /// Save Button
              ///
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 30,
                  bottom: 20,
                ),
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
      ),
    );

    return ResponsiveBuilder(builder: (context, si) {
      if (isFullScreen.value || si.isMobile) {
        return Dialog.fullscreen(
          child: content,
        );
      }

      return Dialog(
        child: SizedBox(
          width: screenSize.width / 2,
          height: screenSize.width / 1.5,
          child: content,
        ),
      );
    });
  }
}
