import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/failures/failure.dart';
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

      /// separate the xFiles and convert it to MultipartFile

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
        title: Text('Patient Create Page'),
      ),
      body: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            ///
            /// name
            ///
            FormBuilderTextField(name: PatientField.name),

            FormBuilderTextField(name: PatientField.name),

            ///
            /// save button
            ///
            LoadingFilledButton(
              isLoading: isLoading.value,
              child: Text('Save'),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
