import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:gym_system/src/core/widgets/stack_loader.dart';
import 'package:gym_system/src/core/widgets/loading_filled_button.dart';

import 'dynamic_field.dart';
import 'dynamic_form_fields.dart';

class DynamicFormResult {
  final Map<String, dynamic> values;
  final List<http.MultipartFile> files;

  DynamicFormResult({required this.values, required this.files});
}

class DynamicFormBuilder extends HookConsumerWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<DynamicField> fields;
  final void Function(DynamicFormResult result) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;
  final EdgeInsets? itemPadding;

  const DynamicFormBuilder({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
    this.itemPadding,
  });

  onFormSubmit(List<DynamicField> fields) async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final rawValues = formKey.currentState!.value;

      final transformedValues = <String, dynamic>{};
      for (final field in fields) {
        final value = rawValues[field.name];

        // Apply the fieldTransformer if it exists
        final transformed = switch (field) {
          DynamicTextField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as String?),
          DynamicTypeAheadField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value),
          DynamicCheckboxField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as bool?),
          DynamicSelectField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value),
          DynamicDateField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as DateTime?),
          DynamicFilesField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as List<PlatformFile>?),
          DynamicImagesField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as List<PlatformFile>?),
          DynamicPBImagesField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as List<PBImage>?),
          _ => value,
        };
        transformedValues[field.name] = transformed;
      }

      final transformedFiles = List<http.MultipartFile>.empty(growable: true);
      for (final field in fields) {
        final value = rawValues[field.name];

        // Apply the fieldTransformer if it exists
        final transformed = switch (field) {
          DynamicPBImagesField f when f.fileTransformer != null =>
            f.fileTransformer!(value as List<PBImage>?),
          _ => value,
        };
        if (transformed is List<Future<http.MultipartFile>>)
          transformedFiles.addAll(await Future.wait(transformed));
      }

      // Now you can use transformedValues as needed
      print('Transformed Values: $transformedValues');
      print('Transformed Files: $transformedFiles');
      // e.g. await someRepo.submitForm(transformedValues);
      onSubmit(DynamicFormResult(
          values: transformedValues, files: transformedFiles));
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
            SliverList.list(children: [
              DynamicFormFields(
                fields: fields,
                itemPadding: itemPadding,
              )
            ]),

            ///
            /// Save Button
            ///
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: LoadingFilledButton(
                  isLoading: isLoading,
                  child: const Text('Save'),
                  onPressed: () => onFormSubmit(fields),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
