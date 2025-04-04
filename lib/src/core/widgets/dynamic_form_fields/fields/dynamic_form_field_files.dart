import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../dynamic_field.dart';

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
