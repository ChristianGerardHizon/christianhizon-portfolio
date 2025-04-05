import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../dynamic_field.dart';

class DynamicFormFieldTypeAhead<T> extends StatelessWidget {
  final DynamicTypeAheadField<T> field;

  const DynamicFormFieldTypeAhead(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead<T>(
      name: field.name,
      decoration: field.decoration,
      validator: field.validator,
      itemBuilder: field.itemBuilder,
      suggestionsCallback: field.onSearch,
    );
  }
}
