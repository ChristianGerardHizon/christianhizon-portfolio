import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../dynamic_field.dart';

/// Represents a dynamic password input field with optional validation and transformation.
class DynamicPasswordField extends DynamicField {
  final String? initialValue;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final bool obscureText;

  const DynamicPasswordField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.fieldTransformer,
    super.decoration,
    super.margin,
    this.obscureText = true,
    super.enabled,
  });
}

class DynamicFormFieldPassword extends HookWidget {
  final DynamicPasswordField field;

  const DynamicFormFieldPassword(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    final obscure = useState(field.obscureText);

    return FormBuilderTextField(
      key: field.formFieldKey,
      name: field.name,
      decoration: field.decoration.copyWith(
        suffixIcon: IconButton(
          onPressed: () => obscure.value = !obscure.value,
          icon: Icon(obscure.value ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      validator: field.validator,
      enabled: field.enabled,
      obscureText: obscure.value,
    );
  }
}
