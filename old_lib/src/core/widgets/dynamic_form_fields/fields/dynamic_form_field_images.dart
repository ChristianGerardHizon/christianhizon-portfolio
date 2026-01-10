import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../dynamic_field.dart';

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
    super.enabled,
  });
}

class DynamicFormFieldImages extends StatelessWidget {
  final DynamicImagesField field;

  const DynamicFormFieldImages(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      name: field.name,
      enabled: field.enabled,

      decoration: field.decoration,
      previewImages: true,
      allowMultiple: false,
      allowedExtensions: field.allowedExtensions,
      compressionQuality: field.allowCompression ? field.compressionQuality : 0,
      maxFiles: field.maxFiles,
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
      validator: field.validator,
    );
  }
}
