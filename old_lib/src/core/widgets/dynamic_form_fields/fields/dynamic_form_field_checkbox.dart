import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicCheckboxField extends DynamicField {
  final bool? initialValue;
  final String title;
  final String? Function(bool?)? validator;
  final dynamic Function(bool?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final Function(bool?)? onChange;
  final EdgeInsets contentPadding;

  const DynamicCheckboxField({
    this.formFieldKey,
    this.contentPadding = EdgeInsets.zero,
    required super.name,
    required this.title,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    super.decoration,
    this.fieldTransformer,
    this.onChange,
    super.margin,
    super.enabled,
  });
}

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
      contentPadding: field.contentPadding,
      title: Text(field.title),
      validator: field.validator,
      valueTransformer: field.valueTransformer,
      onChanged: (x) => field.onChange?.call(x),
    );
  }
}
