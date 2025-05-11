import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/extensions/x_file_extension.dart';

import 'package:gym_system/src/core/models/pb_file.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/utils/image_compressor_utils.dart';
import 'package:http/http.dart';

import '../dynamic_field.dart';

class DynamicPBFilesField extends DynamicField {
  final int maxSizeKB;
  final int compressionQuality;
  final bool allowCompression;
  final double previewSize;
  final int maxFiles;
  final FileType type;
  final List<String>? allowedExtensions;
  final List<PBFile>? initialValue;
  final String? Function(List<PBFile>?)? validator;
  final dynamic Function(List<PBFile>?)? fieldTransformer;
  final List<Future<MultipartFile>> Function(List<PBFile>?)? fileTransformer;

  const DynamicPBFilesField({
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
    super.enabled,
    this.type = FileType.image,
  });
}

class DynamicFormFieldPBFiles extends StatelessWidget {
  final DynamicPBFilesField field;

  const DynamicFormFieldPBFiles(
    this.field, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<PBFile>>(
      name: field.name,
      enabled: field.enabled,
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
                    _PBFileAddButtonWithLoading(
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
  final PBFile image;
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
        errorBuilder: (context, error, stackTrace) {
          return Icon(MIcons.fileOutline, size: size / 2);
        },
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
            Container(
              margin: EdgeInsets.only(top: 8),
              constraints: BoxConstraints(
                maxWidth: size - 20,
              ),
              child: SelectableText(
                name,
                maxLines: 1,
              ),
            ),
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

class _PBFileAddButtonWithLoading extends HookWidget {
  final DynamicPBFilesField field;
  final List<PBFile> existingImages;
  final void Function(List<PBFile>) onImagesPicked;
  final double size;

  const _PBFileAddButtonWithLoading({
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

Future<List<PBFile>> pickAndCompressImages({
  required DynamicPBFilesField field,
  required List<PBFile> existingImages,
}) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: field.maxFiles > 1,
    type: field.type,
    allowedExtensions: field.allowedExtensions,
    withData: true,
  );

  if (result == null) return existingImages;

  final List<PBFile> newImages = [];

  for (final file in result.files) {
    final originalXFile = XFile.fromData(
      file.bytes!,
      name: file.name,
      path: file.path,
      length: file.size,
    );

    final compressed = field.allowCompression && originalXFile.isImageFile
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
          PBLocalFile(
            field: field.name,
            name: compressed.name,
            size: compressedBytes.length,
            bytes: compressedBytes,
            path: compressed.path,
          ),
        );
      } else if (compressedBytes.isNotEmpty) {
        newImages.add(
          PBMemoryFile(
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
