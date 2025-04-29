import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/data/treatment/patient_treatment_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TreatmentCreateSheet extends HookConsumerWidget {
  final Map<String, dynamic>? formData;

  const TreatmentCreateSheet({super.key, this.formData});

  static Future show(
    BuildContext context, {
    Map<String, dynamic>? formData,
  }) async {
    return showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (_) => TreatmentCreateSheet(formData: formData),
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
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
        child: FormBuilder(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              ///
              /// App Bar
              ///
              SliverAppBar(
                backgroundColor: Colors.transparent,
                leading: CloseButton(),
                title: Text('New PatientTreatment Type'),
              ),

              ///
              /// Patient Details
              ///
              SliverPadding(
                padding: EdgeInsets.only(left: 10, right: 10),
                sliver: SliverList.list(
                  children: [
                    SizedBox(height: 10),

                    ///
                    /// Type Name
                    ///
                    FormBuilderTextField(
                      name: TreatmentField.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: 10, right: 8, left: 8, top: 30),
                        labelText: 'Name',
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
