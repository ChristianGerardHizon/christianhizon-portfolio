import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../dynamic_field.dart';

class DynamicFormFieldView extends StatelessWidget {
  final DynamicViewField field;

  const DynamicFormFieldView(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      builder: (x) => field.builder.call(x.value),
      name: field.name,
      enabled: field.enabled,
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
