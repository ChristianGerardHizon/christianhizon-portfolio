import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';

import 'dynamic_field.dart';
import 'dynamic_form_fields.dart';

class DynamicFormBuilder extends HookWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Map<String, dynamic> initialValue;
  final List<DynamicField> fields;
  final void Function(
      Map<String, dynamic> fields, List<http.MultipartFile> files) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;

  const DynamicFormBuilder({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
    this.initialValue = const <String, dynamic>{},
  });

  @override
  Widget build(BuildContext context) {
    return StackLoader(
      isLoading: isLoading,
      opacity: 0.1,
      child: FormBuilder(
        key: formKey,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          if (onChange != null) {
            final current = formKey.currentState?.instantValue ?? {};
            onChange!(current);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverList.list(children: [DynamicFormFields(fields: fields)]),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading,
                  child: const Text('Save'),
                  onPressed: () async {
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      final values = formKey.currentState!.value;
                      final extracted = await _extractFilesAndFields(values);
                      onSubmit(extracted.$1, extracted.$2);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Separates regular fields and file fields.
  Future<(Map<String, dynamic>, List<http.MultipartFile>)>
      _extractFilesAndFields(
    Map<String, dynamic> values,
  ) async {
    final Map<String, dynamic> fields = {};
    final List<http.MultipartFile> files = [];

    for (final entry in values.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is List<PlatformFile>) {
        for (final file in value) {
          if (file.path != null) {
            final multipartFile = await http.MultipartFile.fromPath(
              key,
              file.path!,
              filename: file.name,
            );
            files.add(multipartFile);
          }
        }
      } else {
        fields[key] = value;
      }
    }

    return (fields, files);
  }
}
