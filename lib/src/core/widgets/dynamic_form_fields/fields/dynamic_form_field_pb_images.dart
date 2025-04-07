import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/utils/image_compressor_utils.dart';

import '../dynamic_field.dart';

class DynamicFormFieldPBImages extends StatelessWidget {
  final DynamicPBImagesField field;

  const DynamicFormFieldPBImages(
    this.field, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<PBImage>>(
      name: field.name,
      validator: field.validator,
      initialValue: field.initialValue,
      builder: (formField) {
        final value = formField.value;
        final displayImages = value ?? [];
        final isMaxReached = displayImages.length >= field.maxFiles;

        return InputDecorator(
          decoration: field.decoration.copyWith(
            errorText: formField.errorText,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (field.fileTypeLabel != null)
              //   Padding(
              //     padding: const EdgeInsets.only(bottom: 8.0),
              //     child: Text(
              //       field.fileTypeLabel!,
              //       style: Theme.of(context).textTheme.labelLarge,
              //     ),
              //   ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...displayImages.map(
                    (image) => _PBImagePreviewTile(
                      image: image,
                      onDelete: () {
                        final updated = [...displayImages]..remove(image);
                        formField.didChange(updated.isEmpty ? null : updated);
                      },
                      size: field.previewSize,
                    ),
                  ),
                  if (!isMaxReached)
                    _PBImageAddButtonWithLoading(
                      field: field,
                      existingImages: displayImages,
                      onImagesPicked: (updated) {
                        if (!context.mounted) return;
                        formField.didChange(updated.isEmpty ? null : updated);
                      },
                      size: field.previewSize / 2,
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PBImagePreviewTile extends StatelessWidget {
  final PBImage image;
  final VoidCallback? onDelete;
  final double size; // 👈 image preview size

  const _PBImagePreviewTile({
    required this.image,
    this.onDelete,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = image.maybeMap(
      network: (image) => CachedNetworkImage(
        imageUrl: image.uri.toString(),
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
      local: (image) => Image.memory(
        image.bytes,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
      memory: (image) => Image.memory(
        image.bytes,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
      orElse: () => Icon(Icons.image_not_supported, size: size),
    );

    final name = image.maybeMap(
      network: (image) => image.uri.toString(),
      local: (image) => image.name,
      memory: (image) => image.fullFilename,
      orElse: () => '',
    );

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
            Text(name),
          ],
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

class _PBImageAddButtonWithLoading extends HookWidget {
  final DynamicPBImagesField field;
  final List<PBImage> existingImages;
  final void Function(List<PBImage>) onImagesPicked;
  final double size;

  const _PBImageAddButtonWithLoading({
    required this.field,
    required this.existingImages,
    required this.onImagesPicked,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    Future<void> _pickImages() async {
      isLoading.value = true;

      final updated = await pickAndCompressImages(
        field: field,
        existingImages: existingImages,
      );

      if (!context.mounted) return;

      onImagesPicked(updated);
      isLoading.value = false;
    }

    return InkWell(
      onTap: isLoading.value ? null : _pickImages,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading.value
              ? SizedBox(
                  width: size * 0.4,
                  height: size * 0.4,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.add_a_photo, size: size * 0.375),
        ),
      ),
    );
  }
}

Future<List<PBImage>> pickAndCompressImages({
  required DynamicPBImagesField field,
  required List<PBImage> existingImages,
}) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: field.maxFiles > 1,
    type: FileType.image,
    allowedExtensions: field.allowedExtensions,
    withData: true,
  );

  if (result == null) return existingImages;

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
  return combined.take(field.maxFiles).toList();
}
