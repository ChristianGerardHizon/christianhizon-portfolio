import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

/// Base abstract class for all dynamic form fields.
/// Contains common properties like `name`, `isRequired`, `placeholder`, and `helperText`.
abstract class DynamicField {
  final String name;
  final dynamic initialValue;
  final bool isRequired;
  final InputDecoration decoration;
  final dynamic Function(dynamic)? valueTransformer;

  const DynamicField({
    required this.name,
    this.initialValue,
    this.isRequired = false,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
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
  final String? initialValue;

  const DynamicTextField({
    required super.name,
    this.initialValue,
    super.isRequired = false,
    super.valueTransformer,
    this.label,
    this.minLength,
    this.maxLength,
    this.minLines,
    this.maxLines,
    super.decoration,
  });
}

/// Represents a dynamic checkbox field with an optional initial value.
class DynamicCheckboxField extends DynamicField {
  final bool? initialValue;

  const DynamicCheckboxField({
    required super.name,
    this.initialValue,
    super.isRequired = false,
    super.valueTransformer,
    super.decoration,
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
    this.initialValue,
    super.isRequired = false,
    super.valueTransformer,
    required this.options,
    super.decoration,
  });
}

/// Represents a dynamic date picker field with optional date boundaries and initial value.
class DynamicDateField extends DynamicField {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;

  const DynamicDateField({
    required super.name,
    this.initialValue,
    super.decoration,
    super.isRequired = false,
    super.valueTransformer,
    this.firstDate,
    this.lastDate,
  });
}

/// Represents a dynamic file upload field with an optional label describing the expected file type.
class DynamicFileField extends DynamicField {
  final String? fileTypeLabel;
  final List<XFile>? initialValue;

  const DynamicFileField({
    required super.name,
    this.initialValue,
    super.isRequired = false,
    super.decoration,
    super.valueTransformer,
    this.fileTypeLabel,
  });
}

/// Represents a dynamic image upload field with optional file type label, max file size, and image quality settings.
class DynamicImageField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final int maxFiles;
  final List<String>? allowedExtensions;
  final List<dynamic>? initialValue;

  const DynamicImageField({
    required super.name,
    super.decoration,
    this.initialValue,
    super.isRequired = false,
    this.allowCompression = false,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.fileTypeLabel,
    this.maxSizeKB = 300, // target ~300KB
    this.compressionQuality = 85, // JPEG quality,
  });
}
