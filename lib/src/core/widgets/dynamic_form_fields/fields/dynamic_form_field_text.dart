import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

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
      minLines: field.minLines,
      maxLines: field.maxLines ?? 1,
    );
  }
}
