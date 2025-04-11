import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldDate extends StatelessWidget {
  final DynamicDateField field;

  const DynamicFormFieldDate(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      key: field.formFieldKey,
      enabled: field.enabled,
      name: field.name,
      firstDate: field.firstDate,
      lastDate: field.lastDate,
      inputType: InputType.date,
      decoration: field.decoration,
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
