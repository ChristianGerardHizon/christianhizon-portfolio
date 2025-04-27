import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dynamic_field.dart';
import 'dynamic_form_field.dart';

class DynamicFormFields extends HookWidget {
  final List<DynamicFieldItem> fieldItems;
  final EdgeInsets? itemPadding;

  const DynamicFormFields({
    super.key,
    required this.fieldItems,
    this.itemPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: fieldItems.map((field) {
        return _buildWidget(field, itemPadding);
      }).toList(),
    );
  }
}

Widget _buildWidget(DynamicFieldItem field, EdgeInsets? itemPadding) {
  if (field is DynamicFieldGroup) {
    return Padding(
      padding: field.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: field.alignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: itemPadding ?? EdgeInsets.zero,
            child: field.title,
          ),
          DynamicFormFields(
            fieldItems: field.fields,
            itemPadding: itemPadding,
          ),
        ],
      ),
    );
  }

  if (field is DynamicFieldTwoColumn) {
    if (field.axis == Axis.horizontal) {
      return Padding(
        padding: field.contentPadding,
        child: Column(
          children: [
            Padding(
              padding: field.firstPadding ?? itemPadding ?? EdgeInsets.zero,
              child: DynamicFormField(field: field.first),
            ),
            Padding(
              padding: field.secondPadding ?? itemPadding ?? EdgeInsets.zero,
              child: DynamicFormField(field: field.second),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: field.contentPadding,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: field.firstPadding ?? itemPadding ?? EdgeInsets.zero,
              child: DynamicFormField(field: field.first),
            ),
          ),
          Expanded(
            child: Padding(
              padding: field.secondPadding ?? itemPadding ?? EdgeInsets.zero,
              child: DynamicFormField(field: field.second),
            ),
          ),
        ],
      ),
    );
  }

  if (field is DynamicField) {
    return Padding(
      padding: itemPadding ?? EdgeInsets.zero,
      child: DynamicFormField(field: field),
    );
  }

  throw 'Unknown field type ${field.runtimeType}';
}
