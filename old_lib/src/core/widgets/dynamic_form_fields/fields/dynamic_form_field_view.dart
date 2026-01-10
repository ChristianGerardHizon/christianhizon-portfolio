import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicViewField extends DynamicField {
  final dynamic initialValue;
  final String? Function(dynamic)? validator;
  final dynamic Function(dynamic)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final Widget Function(dynamic) builder;
  final InputDecoration decoration;

  const DynamicViewField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.fieldTransformer,
    super.enabled,
    required this.builder,
    this.decoration = const InputDecoration(),
  });
}

class DynamicFormFieldView extends StatelessWidget {
  final DynamicViewField field;

  const DynamicFormFieldView(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      builder: (x) => InputDecorator(
        decoration: field.decoration.copyWith(errorText: x.errorText),
        child: field.builder.call(x.value),
      ),
      name: field.name,
      enabled: field.enabled,
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
