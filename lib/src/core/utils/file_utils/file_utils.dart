import 'dart:math';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:gym_system/src/core/utils/file_utils/file_utils.dart';
import 'package:http/http.dart' as http;
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

Future<(Uint8List, String)> urlToBytes(Uri uri) async {
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception('Failed to load file from $uri');
  }

  final bytes = response.bodyBytes;
  final name = safeFileNameFromUri(uri);

  return (bytes, name);
}

String safeFileNameFromUri(Uri uri, {String? fallbackExtension}) {
  final lastSegment =
      uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;

  final hasValidName = lastSegment != null && lastSegment.contains('.');
  if (hasValidName) return lastSegment;

  // Generate random fallback like file_ab12cd34.jpg
  final random = _randomHex(8);
  final ext = fallbackExtension ?? 'bin';
  return 'file_$random.$ext';
}

String _randomHex(int length) {
  final rand = Random.secure();
  const chars = 'abcdef0123456789';
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}
