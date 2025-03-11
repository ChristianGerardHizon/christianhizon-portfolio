import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/treatments/data/treatment_record/treatment_record_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:gym_system/src/features/treatments/presentation/widgets/treatment_form_field.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_form_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TreatmentRecordCreateSheet extends HookConsumerWidget {
  final Treatment type;

  final Map<String, dynamic>? formData;

  const TreatmentRecordCreateSheet(
      {super.key, required this.type, this.formData});

  static Future show(
    BuildContext context, {
    required Treatment type,
    Map<String, dynamic>? formData,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) =>
          TreatmentRecordCreateSheet(type: type, formData: formData),
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

      final result =
          await ref.read(treatmentRepositoryProvider).create(form.value).run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          context.pop(r);
        },
      );
    }

    final content = Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text('New ${type.name} History'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FormBuilder(
          key: formKey,
          initialValue: {
            TreatmentRecordField.id: formData?[TreatmentRecordField.id],
            TreatmentRecordField.date:
                formData?[TreatmentRecordField.date] ?? DateTime.now(),
            TreatmentRecordField.patient:
                formData?[TreatmentRecordField.patient],
            TreatmentRecordField.type:
                formData?[TreatmentRecordField.type] ?? type,
          },
          child: CustomScrollView(
            slivers: [
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
                        'Date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: TreatmentRecordField.date,
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
                    TreatmentFormField(
                      name: TreatmentRecordField.type,
                      valueTransformer: (x) => x.id,
                    ),
                  ],
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    // SizedBox(height: 10),
                    // ListTile(
                    //   contentPadding: EdgeInsets.all(0),
                    //   title: Text(
                    //     'Patient Info',
                    //     style: Theme.of(context).textTheme.titleLarge,
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    PatientFormField(
                      name: TreatmentRecordField.patient,
                      valueTransformer: (x) => x.id,
                    ),
                    SizedBox(height: 10),
                    FormBuilderTextField(
                      name: TreatmentRecordField.note,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
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
                    SizedBox(height: 10),
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

    if (isFullScreen.value) {
      return Dialog.fullscreen(
        child: content,
      );
    }
    return Dialog(
      child: SizedBox(
        width: screenSize.width / 2,
        child: content,
      ),
    );
  }
}
