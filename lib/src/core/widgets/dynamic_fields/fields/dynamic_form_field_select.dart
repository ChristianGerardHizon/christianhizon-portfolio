import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../dynamic_field.dart';

class DynamicSelectFormField extends StatelessWidget {
  final DynamicSelectField field;

  const DynamicSelectFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: field.name,
      decoration: InputDecoration(
        labelText: field.name,
        hintText: field.placeholder,
        helperText: field.helperText,
      ),
      validator: FormBuilderValidators.compose([
        if (field.isRequired) FormBuilderValidators.required(),
      ]),
      initialValue: field.initialValue,
      items: field.options
          .map((opt) => DropdownMenuItem(
                value: opt.value,
                child: Text(opt.display),
              ))
          .toList(),
    );
  }
}
