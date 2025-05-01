import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../dynamic_field.dart';

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
    super.enabled,
  });
}

class DynamicFormFieldFiles extends StatelessWidget {
  final DynamicFilesField field;

  const DynamicFormFieldFiles(this.field, {super.key});
  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      name: field.name,
      decoration: field.decoration,
      previewImages: true,
      allowMultiple: false,
      enabled: field.enabled,
      maxFiles: 1,
      typeSelectors: [
        TypeSelector(
          type: FileType.any,
          selector: Row(
            children: const [
              Icon(Icons.attach_file),
              SizedBox(width: 8),
              Text('Choose File'),
            ],
          ),
        ),
      ],
      validator: field.validator,
      valueTransformer: field.valueTransformer,
    );
  }
}
