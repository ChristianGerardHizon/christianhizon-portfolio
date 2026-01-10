import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../dynamic_field.dart';

class DynamicTypeAheadField extends DynamicField {
  final dynamic initialValue;
  final Future<List<dynamic>> Function(String) onSearch;
  final String Function(dynamic) selectionToString;
  final String? Function(dynamic)? validator;
  final dynamic Function(dynamic)? fieldTransformer;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final Function(dynamic)? onChange;

  const DynamicTypeAheadField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    required this.onSearch,
    required this.itemBuilder,
    super.valueTransformer,
    this.fieldTransformer,
    required this.selectionToString,
    this.onChange,
    super.margin,
    super.enabled,
  });
}

class DynamicFormFieldTypeAhead extends StatelessWidget {
  final DynamicTypeAheadField field;

  const DynamicFormFieldTypeAhead(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTypeAhead(
      key: field.formFieldKey,
      name: field.name,
      decoration: field.decoration,
      enabled: field.enabled,
      validator: field.validator,
      itemBuilder: field.itemBuilder,
      suggestionsCallback: field.onSearch,
      selectionToTextTransformer: field.selectionToString,
    );
  }
}
