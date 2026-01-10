import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:sannjosevet/src/features/patients/files/data/patient_file_repository.dart';
import 'package:sannjosevet/src/features/patients/files/domain/patient_file.dart';
import 'package:sannjosevet/src/features/patients/files/presentation/controllers/patient_file_form_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientFileFormPage extends HookConsumerWidget {
  const PatientFileFormPage({super.key, this.id, required this.parentId});

  final String? id;
  final String parentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(patientFileFormControllerProvider(
      parentId: parentId,
      id: id,
    ));

    ///
    /// Submit
    ///
    void onSave(
      PatientFile? patientFile,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(patientFileRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (patientFile == null
          ? repository.create(value, files: files)
          : repository.update(patientFile, value, files: files));

      final result = await task.run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
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
            final patientFile = formState.patientFile;
            final images = formState.images;
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
                /// Patient Record
                ///
                DynamicHiddenField(
                  name: PatientFileField.patient,
                  initialValue: patientFile?.patient ?? parentId,
                ),

                ///
                /// File
                ///
                DynamicPBFilesField(
                  name: PatientFileField.file,
                  type: FileType.any,
                  maxFiles: 1,
                  allowCompression: false,
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
                /// Notes
                ///
                DynamicTextField(
                  name: PatientFileField.notes,
                  initialValue: patientFile?.notes,
                  decoration: InputDecoration(
                    label: Text('Notes'),
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 10,
                  validator: FormBuilderValidators.compose([]),
                ),
              ],
              onSubmit: (result) => onSave(patientFile, result),
            );
          }),
    );
  }
}
