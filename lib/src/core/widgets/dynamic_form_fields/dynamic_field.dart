import 'package:flutter/material.dart';
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_checkbox.dart'
    show DynamicCheckboxField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_date.dart'
    show DynamicDateField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_files.dart'
    show DynamicFilesField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_hidden.dart'
    show DynamicHiddenField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_images.dart'
    show DynamicImagesField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_number.dart'
    show DynamicNumberField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_password.dart'
    show DynamicPasswordField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_pb_files.dart'
    show DynamicPBFilesField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_select.dart'
    show DynamicSelectField, SelectOption;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_text.dart'
    show DynamicTextField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_typeahead.dart'
    show DynamicTypeAheadField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_view.dart'
    show DynamicViewField;
export 'package:gym_system/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_date_time.dart'
    show DynamicDateTimeField;

abstract class DynamicFieldItem {
  const DynamicFieldItem();
}

class DynamicFieldGroup extends DynamicFieldItem {
  final Widget? title;
  final EdgeInsets? padding;
  final CrossAxisAlignment alignment;
  final List<DynamicFieldItem> fields;

  const DynamicFieldGroup({
    this.padding,
    this.alignment = CrossAxisAlignment.start,
    this.title,
    required this.fields,
  });
}

class DynamicFieldTwoColumn extends DynamicFieldItem {
  final DynamicField first;
  final DynamicField second;
  final Axis axis;
  final EdgeInsets? firstPadding;
  final EdgeInsets? secondPadding;
  final EdgeInsets contentPadding;

  const DynamicFieldTwoColumn({
    required this.first,
    required this.second,
    this.firstPadding,
    this.secondPadding,
    this.axis = Axis.horizontal,
    this.contentPadding = EdgeInsets.zero,
  });
}

/// Base abstract class for all dynamic form fields.
abstract class DynamicField extends DynamicFieldItem {
  final String name;
  final dynamic initialValue;
  final InputDecoration decoration;
  final dynamic Function(dynamic)? valueTransformer;
  final EdgeInsets? margin;
  final bool enabled;

  const DynamicField({
    required this.name,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.margin,
    this.enabled = true,
  });
}

extension DynamicFiledListExtension on List<DynamicField> {
  Map<String, dynamic> toInitialValues() {
    final map = <String, dynamic>{};
    for (final field in this) {
      map[field.name] = field.initialValue;
    }
    return map;
  }
}
