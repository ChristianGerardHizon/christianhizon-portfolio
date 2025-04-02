import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../dynamic_field.dart';

class DynamicTextFormField extends StatelessWidget {
  final DynamicTextField field;

  const DynamicTextFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: field.name,
      decoration: field.decoration ??
          InputDecoration(
            labelText: field.label ?? field.name,
            hintText: field.placeholder,
            helperText: field.helperText,
          ),
      validator: FormBuilderValidators.compose([
        if (field.isRequired) FormBuilderValidators.required(),
        if (field.minLength != null)
          FormBuilderValidators.minLength(field.minLength!),
        if (field.maxLength != null)
          FormBuilderValidators.maxLength(field.maxLength!),
      ]),
      minLines: field.minLines,
      maxLines: field.maxLines ?? 1,
    );
  }
}
