import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/settings/presentation/image_viewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CustomImageField extends HookWidget {
  final String name;
  final FormFieldValidator<dynamic>? validator;
  final dynamic initialValue;
  final InputDecoration decoration;
  final Widget Function(BuildContext, String)? stringBuilder;
  final dynamic Function(Object?)? valueTransformer;
  final String feature;
  final String id;

  const CustomImageField({
    super.key,
    required this.name,
    required this.feature,
    required this.id,
    this.validator,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.stringBuilder,
    this.valueTransformer,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<dynamic>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      valueTransformer: valueTransformer,
      builder: (FormFieldState<dynamic> field) {
        final value = field.value;
        return SizedBox(
          height: 185,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    icon: Icon(MIcons.imageOutline),
                    onPressed: () => _pickImage(ImageSource.gallery, field),
                    label: const Text('Pick Image'),
                  ),
                  TextButton.icon(
                    icon: Icon(MIcons.cameraOutline),
                    onPressed: () => _pickImage(ImageSource.camera, field),
                    label: const Text('Capture Image'),
                  ),
                ],
              ),
              if (value != null) const SizedBox(height: 16),
              if (value != null)
                Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Builder(builder: (context) {
                        if (value is String && value.isNotEmpty) {
                          return ImageViewer(
                            builder: (url) => CachedNetworkImage(
                              height: 120,
                              width: 120,
                              imageUrl: url,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            feature: feature,
                            file: value,
                            id: id,
                          );
                        }
                        if (value is XFile) {
                          return Image.file(
                            File(value.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }
                        return SizedBox();
                      }),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          field.didChange(null);
                        },
                      ),
                    ),
                  ],
                )
              else
                SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(
    ImageSource source,
    FormFieldState<dynamic> field,
  ) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      field.didChange(pickedFile);
    }
  }
}
