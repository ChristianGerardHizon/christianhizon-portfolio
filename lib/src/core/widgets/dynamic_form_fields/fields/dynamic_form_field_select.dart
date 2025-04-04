import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldSelect extends StatelessWidget {
  final DynamicSelectField field;

  const DynamicFormFieldSelect(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: field.name,
      decoration: field.decoration,
      validator: field.validator,
      items: field.options
          .map((opt) => DropdownMenuItem(
                value: opt.value,
                child: Text(opt.display),
              ))
          .toList(),
    );
  }
}
