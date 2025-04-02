import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../dynamic_field.dart';

class DynamicFileFormField extends StatelessWidget {
  final DynamicFileField field;

  const DynamicFileFormField(this.field, {super.key});
  @override
  Widget build(BuildContext context) {
    throw FormBuilderFilePicker(
      name: field.name,
      decoration: InputDecoration(
        labelText: field.fileTypeLabel ?? field.name,
        helperText: field.helperText,
      ),
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
      validator: FormBuilderValidators.compose([
        if (field.isRequired)
          FormBuilderValidators.minLength(1, errorText: 'File is required'),
      ]),
    );
  }
}
