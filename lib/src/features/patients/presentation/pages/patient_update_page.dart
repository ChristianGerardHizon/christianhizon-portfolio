import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/routing/main.routes.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/file_picker.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/confirm_modal.dart';
import 'package:gym_system/src/core/widgets/form_builders/images_form_field.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_update_controller.dart';
import 'package:gym_system/src/features/patients/presentation/widgets/patient_image_control_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientUpdatePage extends HookConsumerWidget {
  const PatientUpdatePage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientUpdateControllerProvider(id));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    final provider = patientControllerProvider(id);

    ///
    /// onUpload
    ///
    onUpload(Patient patient) async {
      final repo = ref.read(patientRepositoryProvider);

      final result = await TaskResult<Patient?>.Do(($) async {
        final images = await $(FilePickerUtil.getImage('displayImage'));
        if (images == null || images.isEmpty) return $(TaskResult.right(null));
        return $(repo.update(patient, {}, files: images));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        ref.invalidate(provider);
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
        return $(repo.update(patient, {'displayImage': null}));
      }).run();

      result.fold((l) => AppSnackBar.rootFailure(l), (r) {
        if (r == null) return;
        ref.invalidate(provider);
        AppSnackBar.root(message: 'Successfully Delete Image');
      });
    }

    void onSubmit(Patient patient) async {
      isLoading.value = true;
      final result = await ref
          .read(patientRepositoryProvider)
          .update(patient, formKey.currentState!.value)
          .run();
      if (!context.mounted) return;
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: "Success");
          PatientPageRoute(id).go(context);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => PatientPageRoute(id).go(context),
        ),
        title: Text('Patient Update Page'),
      ),
      body: state.when(
        data: (updateState) {
          final patient = updateState.patient;
          final settings = updateState.settings;
          return FormBuilder(
            key: formKey,
            initialValue: patient.toMap(),
            child: CustomScrollView(
              slivers: [
                SliverList.list(children: [
                  ///
                  /// Display Picture
                  ///
                  PatientImageControlWidget(
                    patient: patient,
                    onUpload: () => onUpload(patient),
                    onImageDiscard: () => onImageDiscard(patient),
                  ),

                  ///
                  /// name
                  ///
                  FormBuilderTextField(name: PatientField.name),

                  SizedBox(height: 10),

                  ImagesFormField(
                    domain:
                        '${settings.domain}/api/files/${PocketBaseCollections.patients}/$id',
                    name: PatientField.images,
                  ),

                  SizedBox(height: 10),
                ]),

                ///
                /// save button
                ///
                SliverToBoxAdapter(
                  child: LoadingFilledButton(
                    isLoading: isLoading.value,
                    child: Text('Save'),
                    onPressed: () => onSubmit(patient),
                  ),
                )
              ],
            ),
          );
        },
        error: (error, stack) {
          return Text(error.toString());
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
