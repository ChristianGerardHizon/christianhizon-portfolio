import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:http/http.dart';

/// Base abstract class for all dynamic form fields.
/// Contains common properties like `name`, `placeholder`, and `helperText`.
abstract class DynamicField {
  final String name;
  final dynamic initialValue;
  final InputDecoration decoration;
  final dynamic Function(dynamic)? valueTransformer;
  final EdgeInsets? margin;
  final dynamic Function(dynamic)? onChange;

  const DynamicField({
    required this.name,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.margin,
    this.onChange,
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
  final int? minLength;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? initialValue;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicTextField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    this.minLength,
    this.maxLength,
    this.minLines,
    this.maxLines,
    super.decoration,
    this.fieldTransformer,
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic checkbox field with an optional initial value and validator.
class DynamicCheckboxField extends DynamicField {
  final bool? initialValue;
  final String? Function(bool?)? validator;
  final dynamic Function(bool?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicCheckboxField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    super.decoration,
    this.fieldTransformer,
    super.onChange,
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
  final dynamic Function(T?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicSelectField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.valueTransformer,
    required this.options,
    super.decoration,
    this.fieldTransformer,
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic date picker field with optional date boundaries and initial value.
class DynamicDateField extends DynamicField {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final String? Function(DateTime?)? validator;
  final dynamic Function(DateTime?)? fieldTransformer;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

  const DynamicDateField({
    this.formFieldKey,
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    super.valueTransformer,
    this.firstDate,
    this.lastDate,
    this.fieldTransformer,
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic searchable dropdown field.
class DynamicTypeAheadField<T> extends DynamicField {
  final dynamic initialValue;
  final Future<List<T>> Function(String) onSearch;
  final String Function(T) selectionToString;
  final String? Function(T)? validator;
  final dynamic Function(T)? fieldTransformer;
  final Widget Function(BuildContext, T) itemBuilder;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;

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
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic file upload field with an optional label describing the expected file type.
class DynamicFilesField extends DynamicField {
  final String? fileTypeLabel;
  final List<XFile>? initialValue;
  final String? Function(List<PlatformFile>?)? validator;
  final dynamic Function(List<PlatformFile>?)? fieldTransformer;

  const DynamicFilesField({
    required super.name,
    this.initialValue,
    this.validator,
    super.decoration,
    super.valueTransformer,
    this.fileTypeLabel,
    this.fieldTransformer,
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic image upload field with optional file type label, max file size, and image quality settings.
class DynamicImagesField extends DynamicField {
  final String? fileTypeLabel;
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final double previewSize;
  final int maxFiles;
  final List<String>? allowedExtensions;
  final List<dynamic>? initialValue;
  final String? Function(List<PlatformFile>?)? validator;
  final dynamic Function(List<PlatformFile>?)? fieldTransformer;

  const DynamicImagesField({
    required super.name,
    super.decoration,
    this.initialValue,
    this.previewSize = 80,
    this.validator,
    this.allowCompression = false,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.fileTypeLabel,
    this.maxSizeKB = 300,
    this.compressionQuality = 85,
    this.fieldTransformer,
    super.margin,
    super.onChange,
  });
}

/// Represents a dynamic image upload field specifically using PBImage model.
class DynamicPBImagesField extends DynamicField {
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final double previewSize;
  final int maxFiles;
  final List<String>? allowedExtensions;
  final List<PBImage>? initialValue;
  final String? Function(List<PBImage>?)? validator;
  final dynamic Function(List<PBImage>?)? fieldTransformer;
  final List<Future<MultipartFile>> Function(List<PBImage>?)? fileTransformer;

  const DynamicPBImagesField({
    required super.name,
    super.decoration,
    this.initialValue,
    this.validator,
    this.previewSize = 80,
    this.allowCompression = false,
    this.allowedExtensions,
    this.maxFiles = 1,
    this.maxSizeKB = 300,
    this.compressionQuality = 85,
    this.fieldTransformer,
    this.fileTransformer,
    super.margin,
    super.onChange,
  });
}
