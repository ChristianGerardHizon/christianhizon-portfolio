import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../dynamic_field.dart';

class DynamicFormFieldTypeAhead extends StatelessWidget {
  final DynamicTypeAheadField field;

  const DynamicFormFieldTypeAhead(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead(
      name: field.name,
      decoration: field.decoration,
      validator: field.validator,
      itemBuilder: field.itemBuilder,
      suggestionsCallback: field.onSearch,
      selectionToTextTransformer: field.selectionToString,
    );
  }
}
