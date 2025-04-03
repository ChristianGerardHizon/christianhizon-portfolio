import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../dynamic_field.dart';

class DynamicCheckboxFormField extends StatelessWidget {
  final DynamicCheckboxField field;

  const DynamicCheckboxFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckbox(
      name: field.name,
      decoration: field.decoration ?? const InputDecoration(),
      title: Text(field.name),
      validator: FormBuilderValidators.compose([
        if (field.isRequired) FormBuilderValidators.equal(true),
      ]),
      valueTransformer: field.valueTransformer,
    );
  }
}
