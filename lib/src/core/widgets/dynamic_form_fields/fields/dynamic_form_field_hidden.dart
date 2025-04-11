import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldHidden extends StatelessWidget {
  final DynamicHiddenField field;

  const DynamicFormFieldHidden(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      builder: (f) => SizedBox(),
      name: field.name,
      enabled: field.enabled,
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
