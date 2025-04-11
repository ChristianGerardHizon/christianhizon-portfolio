// dynamic_form_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_pb_images.dart';
import 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_typeahead.dart';

import 'dynamic_field.dart';
import 'fields/dynamic_form_field_images.dart';
import 'fields/dynamic_form_field_text.dart';
import 'fields/dynamic_form_field_checkbox.dart';
import 'fields/dynamic_form_field_select.dart';
import 'fields/dynamic_form_field_date.dart';
import 'fields/dynamic_form_field_files.dart';

class DynamicFormField extends HookWidget {
  final DynamicField field;
  final EdgeInsets? margin;

  const DynamicFormField({super.key, required this.field, this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: field.margin ?? margin ?? const EdgeInsets.all(0),
      child: Builder(
        builder: (context) {
          if (field is DynamicTextField) {
            return DynamicFormFieldText(field as DynamicTextField);
          }

          if (field is DynamicCheckboxField) {
            return DynamicFormFieldCheckbox(field as DynamicCheckboxField);
          }

          if (field is DynamicSelectField) {
            return DynamicFormFieldSelect(field as DynamicSelectField);
          }

          if (field is DynamicDateField) {
            return DynamicFormFieldDate(field as DynamicDateField);
          }

          if (field is DynamicFilesField) {
            return DynamicFormFieldFiles(field as DynamicFilesField);
          }

          if (field is DynamicImagesField) {
            return DynamicFormFieldImages(field as DynamicImagesField);
          }

          if (field is DynamicPBImagesField) {
            return DynamicFormFieldPBImages(field as DynamicPBImagesField);
          }


          if (field is DynamicTypeAheadField) {
            return DynamicFormFieldTypeAhead(field as DynamicTypeAheadField);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
