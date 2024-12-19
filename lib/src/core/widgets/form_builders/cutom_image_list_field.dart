import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CustomImageListField extends HookWidget {
  final String name;
  final FormFieldValidator<List<dynamic>>? validator;
  final List<dynamic>? initialValue;
  final InputDecoration decoration;
  final Widget Function(BuildContext, String)? stringBuilder;
  final dynamic Function(Object?)? valueTransformer;

  const CustomImageListField({
    super.key,
    required this.name,
    this.validator,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.stringBuilder,
    this.valueTransformer,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<dynamic>>(
      name: name,
      validator: validator,
      initialValue: initialValue,
      valueTransformer: valueTransformer,
      builder: (FormFieldState<List<dynamic>> field) {
        final value = field.value ?? [];
        return Column(
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
            if (value.isNotEmpty) const SizedBox(height: 16),
            if (value.isNotEmpty)
              ...value.map((item) => Stack(
                    children: [
                      if (item is String)
                        stringBuilder?.call(context, item) ?? Text(item),
                      if (item is XFile)
                        Image.file(
                          File(item.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            final newValue = List<dynamic>.from(value)
                              ..remove(item);
                            field.didChange(newValue);
                          },
                        ),
                      ),
                    ],
                  ))
            else
              SizedBox(height: 50),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(
    ImageSource source,
    FormFieldState<List<dynamic>> field,
  ) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final newValue = List<dynamic>.from(field.value ?? [])..add(pickedFile);
      field.didChange(newValue);
    }
  }
}
