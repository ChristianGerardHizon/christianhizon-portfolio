import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldCheckbox extends StatelessWidget {
  final DynamicCheckboxField field;

  const DynamicFormFieldCheckbox(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      key: field.formFieldKey,
      enabled: field.enabled,
      name: field.name,
      decoration: field.decoration,
      title: Text(field.title),
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
