import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dynamic_field.dart';
import 'dynamic_form_field.dart';

class DynamicFormFields extends HookWidget {
  final List<DynamicField> fields;

  const DynamicFormFields({
    super.key,
    required this.fields,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fields.map((field) => DynamicFormField(field: field)).toList(),
    );
  }
}
