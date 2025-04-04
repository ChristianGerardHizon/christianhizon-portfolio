import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<PlatformFile> createPlatformFileFromBytes({
  required String name,
  required List<int> bytes,
  String? identifier,
}) async {
  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/$name';
  final file = File(filePath);
  await file.writeAsBytes(bytes);

  return PlatformFile(
    name: name,
    size: bytes.length,
    path: filePath,
    bytes: null,
  );
}
