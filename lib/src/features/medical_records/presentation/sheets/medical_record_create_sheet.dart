import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/core/widgets/responsive_two_fields.dart';
import 'package:gym_system/src/features/medical_records/data/medical_record_repository.dart';
import 'package:gym_system/src/features/medical_records/domain/medical_record.dart';
import 'package:gym_system/src/features/medical_records/presentation/controllers/medical_record_page_controller.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MedicalRecordCreateSheet extends HookConsumerWidget {
  final Patient patient;
  final MedicalRecord? record;

  const MedicalRecordCreateSheet({
    super.key,
    required this.patient,
    this.record,
  });

  static Future<bool?> show(
    BuildContext context, {
    required Patient patient,
  }) async {
    return showDialog<bool>(
      useSafeArea: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return MedicalRecordCreateSheet(
          patient: patient,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFullScreen = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    ///
    /// Submit
    ///
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
          .read(medicalRecordRepositoryProvider)
          .create(form.value)
          .run();

      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(medicalRecordsPageControllerProvider);
          context.pop();
        },
      );
    }

    Map<String, dynamic> buildInitialValue() {
      return {
        MedicalRecordField.id: record?.id,
        MedicalRecordField.followUpDate: record?.followUpDate,
        MedicalRecordField.vistDate: record?.visitDate ?? DateTime.now(),
        MedicalRecordField.patient: patient,
        MedicalRecordField.treatment: record?.treatment,
        MedicalRecordField.diagnosis: record?.diagnosis,
      };
    }

    final content = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FormBuilder(
          key: formKey,
          initialValue: buildInitialValue(),
          child: CustomScrollView(
            slivers: [
              ///
              ///  Header
              ///
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                leading: CloseButton(),
                title: Text('Add Medical Record'),
              ),

              ///
              /// Patient Information
              ///
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    ///
                    /// Header
                    ///
                    SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Patient',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    ///
                    /// Patient
                    ///
                    PatientFormField(
                      name: MedicalRecordField.patient,
                      valueTransformer: (p0) => p0.id,
                    ),
                  ],
                ),
              ),

              ///
              /// Information
              ///
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    ///
                    /// Header
                    ///
                    SizedBox(height: 10),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Information',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 10),

                    ResponsiveTwoFields(
                      horizontalGap: 8,
                      verticalGap: 8,
                      children: [
                        FormBuilderDateTimePicker(
                          initialEntryMode: DatePickerEntryMode.calendar,
                          inputType: InputType.date,
                          name: MedicalRecordField.vistDate,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month),
                            contentPadding: EdgeInsets.only(
                                bottom: 10, right: 8, left: 8, top: 30),
                            labelText: 'Visitation Date',
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          valueTransformer: (dateTime) {
                            if (dateTime == null) return null;
                            return dateTime.toUtc().toIso8601String();
                          },
                        ),
                        FormBuilderDateTimePicker(
                          initialEntryMode: DatePickerEntryMode.calendar,
                          inputType: InputType.date,
                          name: MedicalRecordField.followUpDate,
                          decoration: InputDecoration(
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    formKey
                                        .currentState
                                        ?.fields[
                                            MedicalRecordField.followUpDate]
                                        ?.didChange(null);
                                  },
                                  icon: Icon(Icons.clear),
                                ),
                                Icon(Icons.calendar_month),
                                SizedBox(width: 8),
                              ],
                            ),
                            contentPadding: EdgeInsets.only(
                              bottom: 10,
                              right: 8,
                              left: 8,
                              top: 30,
                            ),
                            labelText: 'Follow Up Date',
                            filled: true,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
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
                    SizedBox(height: 16),

                    ResponsiveTwoFields(
                        verticalGap: 8,
                        horizontalGap: 8,
                        children: [
                          ///
                          /// Diagnosis
                          ///
                          FormBuilderTextField(
                            name: MedicalRecordField.diagnosis,
                            validator: FormBuilderValidators.compose([]),
                            minLines: 5,
                            maxLines: 8,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 10,
                                right: 8,
                                left: 8,
                                top: 30,
                              ),
                              labelText: 'Diagnosis',
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),

                          ///
                          /// Treatment
                          ///
                          FormBuilderTextField(
                            name: MedicalRecordField.treatment,
                            validator: FormBuilderValidators.compose([]),
                            minLines: 5,
                            maxLines: 8,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 10,
                                right: 8,
                                left: 8,
                                top: 30,
                              ),
                              labelText: 'Treatment',
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerLow,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),

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
      ),
    );

    return ResponsiveBuilder(builder: (context, si) {
      final screenSize = MediaQuery.of(context).size;

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
