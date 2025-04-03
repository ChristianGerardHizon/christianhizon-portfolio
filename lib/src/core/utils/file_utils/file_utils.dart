import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:mime/mime.dart';

export 'file_utils_io.dart' if (dart.library.html) 'file_utils_web.dart';

Future<String?> saveBytesToFile({
  required Uint8List bytes,
  required String filename,
}) async {
  try {
    final extension = filename.split('.').last;
    final mimeType = lookupMimeType(filename) ?? 'application/octet-stream';

    final path = await FileSaver.instance.saveFile(
      name: filename.replaceAll('.$extension', ''),
      bytes: bytes,
      ext: extension,
      mimeType: MimeType.other, // Required by the API
      customMimeType: mimeType, // Custom MIME type as a string
    );

    return path;
  } catch (e) {
    print('Error saving file: $e');
    return null;
  }
}
