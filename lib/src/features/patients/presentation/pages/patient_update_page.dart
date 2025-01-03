import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_update_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientUpdatePage extends HookConsumerWidget {
  const PatientUpdatePage(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientUpdateControllerProvider(id));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);

    void onSubmit(Patient patient) async {
      isLoading.value = true;
      final result = await ref
          .read(patientRepositoryProvider)
          .update(patient, formKey.currentState!.value)
          .run();
      isLoading.value = false;
      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) => context.pop(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Update Page'),
      ),
      body: state.when(
        data: (patient) {
          return FormBuilder(
            key: formKey,
            child: Column(
              children: [
                ///
                /// name
                ///

                FormBuilderTextField(name: PatientField.name),

                ///
                /// save button
                ///
                LoadingFilledButton(
                  isLoading: isLoading.value,
                  child: Text('Save'),
                  onPressed: () => onSubmit(patient),
                ),
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
