import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<PlatformFile> createPlatformFileFromBytes({
  required String name,
  required Uint8List bytes,
}) async {
  return PlatformFile(
    name: name,
    size: bytes.length,
    bytes: bytes,
    path: null,
  );
}
