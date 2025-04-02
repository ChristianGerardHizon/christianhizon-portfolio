import 'package:flutter/material.dart';

/// Base abstract class for all dynamic form fields.
/// Contains common properties like `name`, `isRequired`, `placeholder`, and `helperText`.
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

/// Represents a dynamic text input field with optional label, length,
/// number of lines, and line constraints.
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

/// Represents a dynamic checkbox field with an optional initial value.
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

/// Model class representing an individual option in a select/dropdown field.
class SelectOption<T> {
  final T value;
  final String display;

  const SelectOption({
    required this.value,
    required this.display,
  });
}

/// Represents a dynamic dropdown/select field with a list of options and an optional initial value.
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

/// Represents a dynamic date picker field with optional date boundaries and initial value.
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

/// Represents a dynamic file upload field with an optional label describing the expected file type.
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

/// Represents a dynamic image upload field with optional file type label, max file size, and image quality settings.
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
