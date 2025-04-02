import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;

import '../dynamic_field.dart';

class _CompressImageArgs {
  final String path;
  final int maxSizeKB;
  final int quality;

  _CompressImageArgs(this.path, this.maxSizeKB, this.quality);
}

Future<File?> compressImageInIsolate(
  File file, {
  required int maxSizeKB,
  int quality = 85,
}) async {
  return compute<_CompressImageArgs, File?>(
    _compressImageSync,
    _CompressImageArgs(file.path, maxSizeKB, quality),
  );
}

File? _compressImageSync(_CompressImageArgs args) {
  final file = File(args.path);
  final rawBytes = file.readAsBytesSync();
  final image = img.decodeImage(rawBytes);
  if (image == null) return null;

  int currentQuality = args.quality;
  Uint8List? compressed;

  do {
    compressed =
        Uint8List.fromList(img.encodeJpg(image, quality: currentQuality));
    currentQuality -= 5;
  } while (
      compressed.lengthInBytes > args.maxSizeKB * 1024 && currentQuality > 10);

  final tempDir = Directory.systemTemp;
  final fileName = path.basenameWithoutExtension(args.path);
  final compressedPath = path.join(tempDir.path, '$fileName-compressed.jpg');

  return File(compressedPath)..writeAsBytesSync(compressed);
}

class DynamicImageFormField extends StatelessWidget {
  final DynamicImageField field;

  const DynamicImageFormField(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
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
      onChanged: (val) async {
        if (val == null || val.isEmpty || val.first.path == null) return;
        final originalFile = File(val.first.path!);
        final compressedFile = await compressImageInIsolate(
          originalFile,
          quality: field.quality,
          maxSizeKB: field.maxSizeKB,
        );

        if (compressedFile != null) {
          final updated = PlatformFile(
            name: path.basename(compressedFile.path),
            path: compressedFile.path,
            size: await compressedFile.length(),
            bytes: await compressedFile.readAsBytes(),
          );

          Future.delayed(Duration.zero, () {
            FormBuilder.of(context)?.fields[field.name]?.didChange([updated]);
          });
        }
      },
      validator: FormBuilderValidators.compose([
        if (field.isRequired)
          FormBuilderValidators.minLength(1, errorText: 'Image required'),
      ]),
    );
  }
}
