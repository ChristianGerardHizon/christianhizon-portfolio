// dynamic_form_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'dynamic_field.dart';
import 'fields/dynamic_form_field_image.dart';
import 'fields/dynamic_form_field_text.dart';
import 'fields/dynamic_form_field_checkbox.dart';
import 'fields/dynamic_form_field_select.dart';
import 'fields/dynamic_form_field_date.dart';
import 'fields/dynamic_form_field_file.dart';

class DynamicFormField extends HookWidget {
  final DynamicField field;

  const DynamicFormField({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    if (field is DynamicTextField) {
      return DynamicTextFormField(field as DynamicTextField);
    }

    if (field is DynamicCheckboxField) {
      return DynamicCheckboxFormField(field as DynamicCheckboxField);
    }

    if (field is DynamicSelectField) {
      return DynamicSelectFormField(field as DynamicSelectField);
    }

    if (field is DynamicDateField) {
      return DynamicDateFormField(field as DynamicDateField);
    }

    if (field is DynamicFileField) {
      return DynamicFileFormField(field as DynamicFileField);
    }

    if (field is DynamicImageField) {
      return DynamicImageFormField(field as DynamicImageField);
    }

    return const SizedBox.shrink();
  }
}
