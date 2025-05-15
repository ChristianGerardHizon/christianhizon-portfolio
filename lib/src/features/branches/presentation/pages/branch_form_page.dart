import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_form_controller.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branch_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BranchFormPage extends HookConsumerWidget {
  const BranchFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(branchFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      Branch? branch,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(branchRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (branch == null
          ? repository.create(value, files: files)
          : repository.update(branch, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(branchTableControllerProvider);
          context.pop(r);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Form Error')),
          data: (formState) {
            final branch = formState.branch;

            return Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: DynamicFormBuilder(
                formKey: formKey,
                isLoading: isLoading.value,
                fields: [
                  DynamicTextField(
                      name: BranchField.name,
                      initialValue: branch?.name,
                      decoration: const InputDecoration(
                          label: Text('Name'), border: OutlineInputBorder())),
                ],
                onSubmit: (result) => onSave(branch, result),
              ),
            );
          }),
    );
  }
}
