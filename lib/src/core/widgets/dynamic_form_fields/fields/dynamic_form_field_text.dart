import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicTextField extends DynamicField {
  final int? minLength;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? initialValue;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicTextField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.minLength,
    this.maxLength,
    this.minLines,
    this.maxLines,
    super.decoration,
    this.fieldTransformer,
    super.margin,
    super.enabled,
  });
}

class DynamicFormFieldText extends StatelessWidget {
  final DynamicTextField field;

  const DynamicFormFieldText(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: field.formFieldKey,
      name: field.name,
      decoration: field.decoration,
      validator: field.validator,
      enabled: field.enabled,
      minLines: field.minLines,
      maxLines: field.maxLines ?? 1,
    );
  }
}
