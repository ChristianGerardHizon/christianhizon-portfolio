import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
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

            return DynamicFormBuilder(
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
              ],
              onSubmit: (result) => onSave(patient, result),
            );
          }),
    );
  }
}
