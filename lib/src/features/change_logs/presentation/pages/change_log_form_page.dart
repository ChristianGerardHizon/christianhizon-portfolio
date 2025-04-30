import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_field.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/dynamic_form_field_builder.dart';
import 'package:gym_system/src/features/change_logs/data/change_log_repository.dart';
import 'package:gym_system/src/features/change_logs/domain/change_log.dart';
import 'package:gym_system/src/features/change_logs/presentation/controllers/change_log_controller.dart';
import 'package:gym_system/src/features/change_logs/presentation/controllers/change_log_form_controller.dart';
import 'package:gym_system/src/features/change_logs/presentation/controllers/change_log_table_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangeLogFormPage extends HookConsumerWidget {
  const ChangeLogFormPage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = useState(false);
    final provider = ref.watch(changeLogFormControllerProvider(id));

    ///
    /// Submit
    ///
    void onSave(
      ChangeLog? changeLog,
      DynamicFormResult formResult,
    ) async {
      isLoading.value = true;

      final repository = ref.read(changeLogRepositoryProvider);
      final value = formResult.values;
      final files = formResult.files;

      final task = (changeLog == null
          ? repository.create(value, files: files)
          : repository.update(changeLog, value, files: files));

      final result = await task.run();

      isLoading.value = false;

      result.fold(
        (l) => AppSnackBar.rootFailure(l),
        (r) {
          AppSnackBar.root(message: 'Success');
          ref.invalidate(changeLogTableControllerProvider);
          ref.invalidate(changeLogControllerProvider(r.id));

          context.pop();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ChangeLog Form Page'),
      ),
      body: provider.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (formState) {
            final changeLog = formState.changeLog;

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
                /// ChangeLog Name
                ///
                DynamicTextField(
                  name: ChangeLogField.message,
                  initialValue: changeLog?.message,
                  decoration: InputDecoration(
                    label: Text('ChangeLog Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),

                ///
                /// Type
                ///
                DynamicSelectField(
                  name: ChangeLogField.type,
                  initialValue: changeLog?.type,
                  options: ChangeLogType.values
                      .map((e) => SelectOption(value: e.name, display: e.name))
                      .toList(),
                  decoration: InputDecoration(
                    label: Text('Type'),
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                )
              ],
              onSubmit: (result) => onSave(changeLog, result),
            );
          }),
    );
  }
}
