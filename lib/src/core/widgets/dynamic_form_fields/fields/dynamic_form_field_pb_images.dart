import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';

import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/utils/image_compressor_utils.dart';

import '../dynamic_field.dart';

class DynamicFormFieldPBImages extends StatelessWidget {
  final DynamicPBImagesField field;

  const DynamicFormFieldPBImages(this.field, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<PBImage>>(
      name: field.name,
      validator: field.validator,
      builder: (formField) {
        final value = formField.value ?? [];

        final isMaxReached = value.length >= field.maxFiles;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (field.fileTypeLabel != null)
              Text(
                field.fileTypeLabel!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...value.map(
                  (image) => _PBImagePreviewTile(
                    image: image,
                    onDelete: () {
                      final updated =
                          [...value].where((x) => x != image).toList();
                      formField.didChange(updated);
                    },
                  ),
                ),
                if (!isMaxReached)
                  _PBImageAddButton(
                    onAdd: () async {
                      final updated = await _pickAndCompressImages(
                        field: field,
                        existingImages: value,
                      );
                      if (updated != null) {
                        formField.didChange(updated);
                      }
                    },
                  ),
              ],
            ),
            if (formField.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  formField.errorText ?? '',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<List<PBImage>?> _pickAndCompressImages({
    required DynamicPBImagesField field,
    required List<PBImage> existingImages,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: field.maxFiles > 1,
      type: FileType.image,
      allowedExtensions: field.allowedExtensions,
      withData: true,
    );

    if (result == null) return null;

    final List<PBImage> newImages = [];

    for (final file in result.files) {
      final originalXFile = XFile.fromData(
        file.bytes!,
        name: file.name,
        path: file.path,
        length: file.size,
      );

      final compressed = field.allowCompression
          ? await ImageCompressorUtils.compress(
              file: originalXFile,
              maxSizeKB: field.maxSizeKB,
              quality: field.compressionQuality,
            )
          : originalXFile;

      if (compressed != null) {
        final compressedBytes = await compressed.readAsBytes();

        if (compressedBytes.isNotEmpty && compressed.path.isNotEmpty) {
          newImages.add(
            PBLocalImage(
              field: field.name,
              name: compressed.name,
              size: compressedBytes.length,
              bytes: compressedBytes,
              path: compressed.path,
            ),
          );
        } else if (compressedBytes.isNotEmpty) {
          newImages.add(
            PBMemoryImage(
              fullFilename: compressed.name,
              field: field.name,
              bytes: compressedBytes,
            ),
          );
        }
      }
    }

    if (field.maxFiles == 1) {
      return newImages.isNotEmpty ? [newImages.first] : existingImages;
    }

    final combined = [...existingImages, ...newImages];
    return combined.take(field.maxFiles).toList(); // truncate if needed
  }
}

class _PBImagePreviewTile extends StatelessWidget {
  final PBImage image;
  final VoidCallback? onDelete;

  const _PBImagePreviewTile({
    required this.image,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = image.maybeMap(
      network: (image) => Image.network(
        image.uri.toString(),
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      local: (image) => Image.memory(
        image.bytes,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      memory: (image) => Image.memory(
        image.bytes,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
      orElse: () => const Icon(Icons.image_not_supported, size: 80),
    );

    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: imageWidget,
        ),
        Positioned(
          right: 0,
          child: InkWell(
            onTap: onDelete,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class _PBImageAddButton extends StatelessWidget {
  final VoidCallback onAdd;

  const _PBImageAddButton({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAdd,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(Icons.add_a_photo, size: 30),
        ),
      ),
    );
  }
}
