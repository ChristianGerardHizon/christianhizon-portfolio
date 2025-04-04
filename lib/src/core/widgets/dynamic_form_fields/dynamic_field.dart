import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';

/// Base abstract class for all dynamic form fields.
/// Contains common properties like `name`, `placeholder`, and `helperText`.
abstract class DynamicField {
  final String name;
  final dynamic initialValue;
  final InputDecoration decoration;
  final dynamic Function(dynamic)? valueTransformer;

  const DynamicField({
    required this.name,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
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

/// Represents a dynamic text input field with optional label, length,
/// number of lines, and line constraints.
class DynamicTextField extends DynamicField {
  final String? label;
  final int? minLength;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? initialValue;
  final String? Function(String?)? validator;

  const DynamicTextField({
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.label,
    this.minLength,
    this.maxLength,
    this.minLines,
    this.maxLines,
    super.decoration,
  });
}

/// Represents a dynamic checkbox field with an optional initial value and validator.
class DynamicCheckboxField extends DynamicField {
  final bool? initialValue;
  final String? Function(bool?)? validator;

  const DynamicCheckboxField({
    required super.name,
    this.initialValue,
    this.validator,
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
  final String? Function(T?)? validator;

  const DynamicSelectField({
    required super.name,
    this.initialValue,
    this.validator,
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
  final String? Function(DateTime?)? validator;

  const DynamicDateField({
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    super.valueTransformer,
    this.firstDate,
    this.lastDate,
  });
}

/// Represents a dynamic file upload field with an optional label describing the expected file type.
class DynamicFilesField extends DynamicField {
  final String? fileTypeLabel;
  final List<XFile>? initialValue;
  final String? Function(List<PlatformFile>?)? validator;

  const DynamicFilesField({
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    super.valueTransformer,
    this.fileTypeLabel,
  });
}

/// Represents a dynamic image upload field with optional file type label, max file size, and image quality settings.
class DynamicImagesField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final int maxFiles;
  final List<String>? allowedExtensions;
  final List<dynamic>? initialValue;
  final String? Function(List<PlatformFile>?)? validator;

  const DynamicImagesField({
    required super.name,
    super.decoration,
    this.initialValue,
    this.validator,
    this.allowCompression = false,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.fileTypeLabel,
    this.maxSizeKB = 300, // target ~300KB
    this.compressionQuality = 85, // JPEG quality
  });
}

class DynamicPBImagesField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final int maxFiles;
  final List<String>? allowedExtensions;
  final List<PBImage>? initialValue;
  final String? Function(List<PBImage>?)? validator;

  const DynamicPBImagesField({
    required super.name,
    super.decoration,
    this.initialValue,
    this.validator,
    this.allowCompression = false,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.fileTypeLabel,
    this.maxSizeKB = 300, // target ~300KB
    this.compressionQuality = 85, // JPEG quality
  });
}

class DynamicImageField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final List<String>? allowedExtensions;
  final List<dynamic>? initialValue;
  final String? Function(PlatformFile?)? validator;

  const DynamicImageField({
    required super.name,
    super.decoration,
    this.initialValue,
    this.validator,
    this.allowCompression = false,
    this.allowedExtensions,
    this.fileTypeLabel,
    this.maxSizeKB = 300, // target ~300KB
    this.compressionQuality = 85, // JPEG quality
  });
}
