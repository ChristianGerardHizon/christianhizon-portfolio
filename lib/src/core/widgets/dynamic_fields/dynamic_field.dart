import 'package:flutter/material.dart';

/// Base abstract class for all dynamic fields.
abstract class DynamicField {
  final String name;
  final bool isRequired;
  final String? placeholder;
  final String? helperText;

  const DynamicField({
    required this.name,
    this.isRequired = false,
    this.placeholder,
    this.helperText,
  });
}

class DynamicTextField extends DynamicField {
  final String? label;
  final int? minLength;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final InputDecoration? decoration;

  const DynamicTextField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    this.label,
    this.minLength,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.decoration,
  });
}

class DynamicCheckboxField extends DynamicField {
  final bool initialValue;

  const DynamicCheckboxField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    this.initialValue = false,
  });
}

class SelectOption<T> {
  final T value;
  final String display;

  const SelectOption({
    required this.value,
    required this.display,
  });
}

class DynamicSelectField<T> extends DynamicField {
  final List<SelectOption<T>> options;
  final T? initialValue;

  const DynamicSelectField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    required this.options,
    this.initialValue,
  });
}

class DynamicDateField extends DynamicField {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DynamicDateField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });
}

class DynamicFileField extends DynamicField {
  final String? fileTypeLabel;

  const DynamicFileField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    this.fileTypeLabel,
  });
}

class DynamicImageField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int quality;

  const DynamicImageField({
    required super.name,
    super.isRequired = false,
    super.placeholder,
    super.helperText,
    this.fileTypeLabel,
    this.maxSizeKB = 300, // target ~300KB
    this.quality = 85, // JPEG quality
  });
}
