import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../dynamic_field.dart';

class DynamicFormFieldNumber extends HookWidget {
  final DynamicNumberField field;

  const DynamicFormFieldNumber(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: field.formFieldKey,
      name: field.name,
      decoration: field.decoration,
      validator: field.validator,
      enabled: field.enabled,
      keyboardType: TextInputType.number,
      valueTransformer: (value) =>
          value == null || value.isEmpty ? null : num.tryParse(value),
    );
  }
}
