import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../dynamic_field.dart';

class DynamicDateFormField extends StatelessWidget {
  final DynamicDateField field;

  const DynamicDateFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: field.name,
      firstDate: field.firstDate,
      lastDate: field.lastDate,
      inputType: InputType.date,
      decoration: field.decoration,
      validator: FormBuilderValidators.compose([
        if (field.isRequired) FormBuilderValidators.required(),
      ]),
      valueTransformer: field.valueTransformer,
    );
  }
}
