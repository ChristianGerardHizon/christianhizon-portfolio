import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gym_system/src/core/extensions/platform_file.dart';
import 'package:gym_system/src/core/utils/form_utils.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';

import 'dynamic_field.dart';
import 'dynamic_form_fields.dart';

class DynamicFormBuilder extends HookConsumerWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<DynamicField> fields;
  final void Function(
    Map<String, dynamic> fields,
    List<http.MultipartFile> files,
  ) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;

  const DynamicFormBuilder({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
  });

  Map<String, dynamic> buildInitial() {
    final result = <String, dynamic>{};
    for (var field in fields) {
      result[field.name] = field.initialValue;
    }
    return result;
  }

  onFormSubmit() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final values = formKey.currentState!.value;
      final extracted = await PBUtils.transformForm(values);
      print(extracted);
      // onSubmit(extracted.$1, extracted.$2);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StackLoader(
      isLoading: isLoading,
      opacity: 0.1,
      child: FormBuilder(
        key: formKey,
        initialValue: fields.toInitialValues(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          if (onChange != null) {
            final current = formKey.currentState?.instantValue ?? {};
            onChange!(current);
          }
        },
        child: CustomScrollView(
          slivers: [
            ///
            /// Widgets
            ///
            SliverList.list(children: [DynamicFormFields(fields: fields)]),

            ///
            /// Save Button
            ///
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading,
                  child: const Text('Save'),
                  onPressed: onFormSubmit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
