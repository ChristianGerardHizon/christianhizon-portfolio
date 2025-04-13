import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/form_builders/hidden_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/data/precription/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_item.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/prescriptions/patient_prescription_all_items_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PatientPrescriptionItemUpdateSheet extends HookConsumerWidget {
  final PrescriptionItem item;

  final Map<String, dynamic>? formData;

  const PatientPrescriptionItemUpdateSheet({
    super.key,
    required this.item,
    this.formData,
  });

  static Future show(
    BuildContext context, {
    required PrescriptionItem item,
    Map<String, dynamic>? formData,
  }) async {
    final screenSize = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) => PatientPrescriptionItemUpdateSheet(
        item: item,
        formData: formData,
      ),
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
      final value = form.instantValue;

      final result = await ref
          .read(patientPrescriptionItemRepositoryProvider)
          .update(item, value)
          .run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(patientPrescriptionAllItemsControllerProvider(
              id: item.patientRecord));
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
            PrescriptionItemField.id: formData?[PrescriptionItemField.id],
            PrescriptionItemField.patientRecord: item.patientRecord,
            PrescriptionItemField.medication: item.medication,
            PrescriptionItemField.dosage: item.dosage,
            PrescriptionItemField.instructions: item.instructions,
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: CloseButton(),
                title: Text('Update Prescription Item'),
              ),

              SliverList.list(
                children: [
                  HiddenFormField(name: PrescriptionItemField.patientRecord),

                  ///
                  /// Medication
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Medication',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  FormBuilderTextField(
                    name: PrescriptionItemField.medication,
                    maxLines: 10,
                    minLines: 3,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Medication',
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
                  /// Dosage
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Dosage',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  FormBuilderTextField(
                    name: PrescriptionItemField.dosage,
                    maxLines: 10,
                    minLines: 3,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Dosage',
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
                  /// Instruction
                  ///
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Instructions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  FormBuilderTextField(
                    name: PrescriptionItemField.instructions,
                    maxLines: 10,
                    minLines: 3,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          bottom: 10, right: 8, left: 8, top: 30),
                      labelText: 'Instructions',
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
          width: screenSize.width / 1.5,
          height: screenSize.width / 1.5,
          child: content,
        ),
      );
    });
  }
}
