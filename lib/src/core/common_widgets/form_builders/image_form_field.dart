import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gym_system/src/core/common_widgets/form_builders/xfile_widget.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

///
/// Used for handling image fields
///
class ImageFormField extends StatefulHookConsumerWidget {
  const ImageFormField({
    super.key,
    required this.name,
  });

  final String name;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ImageFormFieldState();
}

class ImageFormFieldState extends ConsumerState<ImageFormField> {
  final key = GlobalKey<FormFieldState<XFile>>();

  TaskResult<XFile?> captureImage() {
    return TaskResult.tryCatch(() async {
      final imagePicker = ImagePicker();
      final xImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (xImage == null) return null;
      return _xFileCompress(xImage);
    }, Failure.presentation);
  }

  @override
  Widget build(BuildContext context) {
    final error = useState<String?>(null);

    onCamera() async {
      error.value = null;
      final result = await captureImage().run();
      if (!context.mounted) return;

      result.fold(
        (l) => error.value = l.toString(),
        (r) => key.currentState?.didChange(r),
      );
    }

    onFile() async {
      error.value = null;

      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.image,
        );
        if (!context.mounted) return;
        final platformFile = result?.files.firstOrNull;
        if (platformFile == null) throw Exception('no selected file');
        // final compressedImage = await _xFileCompress(platformFile.xFile);
        key.currentState?.didChange(platformFile.xFile);
      } catch (e) {
        if (!context.mounted) return;
        error.value = e.toString();
      }
    }

    return FormBuilderField<XFile>(
      key: key,
      name: widget.name,
      validator: (file) {
        if (file == null) return 'File is required';
        return null;
      },
      builder: (field) {
        final file = field.value;
        if (file is XFile) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  XFileWidget(file: file),
                  const SizedBox(height: 10),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(file.name),
                    trailing: TextButton.icon(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                            Theme.of(context).colorScheme.error),
                      ),
                      onPressed: () => field.didChange(null),
                      icon: Icon(MIcons.deleteCircle),
                      label: const Text('Discard'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  if (!Platform.isWindows)
                    Expanded(
                      child: TextButton.icon(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        label: const Text('Camera'),
                        icon: Icon(MIcons.camera),
                        onPressed: onCamera,
                      ),
                    ),
                  if (!Platform.isWindows) const SizedBox(width: 4),
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      label: const Text('Gallery'),
                      icon: Icon(MIcons.imageAlbum),
                      onPressed: onFile,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            if (error.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    error.value ?? 'something went wrong',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    field.errorText!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

Future<XFile> _xFileCompress(XFile xImage) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Get original image file name and extension
  String originalFileName =
      xImage.path.split('/').last; // Get file name from path

  // Construct new file path in temporary directory
  String newFilePath = '$tempPath/${DateTime.now().toUtc()}-$originalFileName';

  // Compress image and get compressed file
  final compressedFile = await FlutterImageCompress.compressAndGetFile(
    xImage.path,
    newFilePath,
    autoCorrectionAngle: true,
    keepExif: true,
    numberOfRetries: 3,
  );

  if (compressedFile == null) throw Exception('Compression error');

  return compressedFile;
}
