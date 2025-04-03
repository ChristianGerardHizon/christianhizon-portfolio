import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../dynamic_field.dart';

class DynamicImageFormField extends StatelessWidget {
  final DynamicImageField field;

  const DynamicImageFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      name: field.name,
      decoration: field.decoration,
      previewImages: true,
      allowMultiple: false,
      allowedExtensions: field.allowedExtensions,
      compressionQuality: field.compressionQuality,
      maxFiles: field.maxFiles,
      allowCompression: field.allowCompression,
      typeSelectors: [
        TypeSelector(
          type: FileType.image,
          selector: Row(
            children: const [
              Icon(Icons.image),
              SizedBox(width: 8),
              Text('Select Image'),
            ],
          ),
        ),
      ],
      onFileLoading: (status) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text('Compressing image...'),
            Text(status.name),
          ],
        ),
      ),
      valueTransformer: field.valueTransformer,
      // onChanged: (val) async {
      //   if (val == null || val.isEmpty || val.first.bytes == null) return;

      //   final file = XFile.fromData(
      //     val.first.bytes!,
      //     name: val.first.name,
      //     mimeType: val.first.extension != null
      //         ? 'image/${val.first.extension}'
      //         : null,
      //   );

      //   final compressedFile = await ImageCompressor.compress(
      //     file: file,
      //     quality: field.compressionQuality ?? 85,
      //     maxSizeKB: field.maxSizeKB ?? 300,
      //   );

      //   if (compressedFile != null) {
      //     final updated = PlatformFile(
      //       name: compressedFile.name,
      //       size: await compressedFile.length(),
      //       bytes: await compressedFile.readAsBytes(),
      //     );

      //     Future.delayed(Duration.zero, () {
      //       FormBuilder.of(context)?.fields[field.name]?.didChange([updated]);
      //     });
      //   }
      // },
      validator: FormBuilderValidators.compose([
        if (field.isRequired)
          FormBuilderValidators.minLength(1, errorText: 'Image required'),
      ]),
    );
  }
}
