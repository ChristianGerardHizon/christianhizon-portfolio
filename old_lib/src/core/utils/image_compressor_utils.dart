import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageCompressorUtils {
  /// Compress an image using isolate, returning a new [XFile] with a file path
  static Future<XFile?> compress({
    required XFile file,
    required int maxSizeKB,
    int quality = 85,
  }) async {
    final bytes = await file.readAsBytes();

    final resultBytes = await compute<_CompressImageArgs, Uint8List?>(
      _compressInIsolate,
      _CompressImageArgs(
        bytes: bytes,
        maxSizeKB: maxSizeKB,
        quality: quality,
        originalName: file.name,
      ),
    );

    if (resultBytes == null) return null;

    // Write to temp file
    final tempDir = await getTemporaryDirectory();
    final compressedFilePath = path.join(
      tempDir.path,
      '${path.basenameWithoutExtension(file.name)}-compressed.jpg',
    );

    final compressedFile =
        await File(compressedFilePath).writeAsBytes(resultBytes);

    return XFile(
      compressedFile.path,
      mimeType: 'image/jpeg',
      name: path.basename(compressedFile.path),
    );
  }

  static Uint8List? _compressInIsolate(_CompressImageArgs args) {
    final image = img.decodeImage(args.bytes);
    if (image == null) return null;

    int currentQuality = args.quality;
    Uint8List? compressed;

    do {
      compressed = Uint8List.fromList(
        img.encodeJpg(image, quality: currentQuality),
      );
      currentQuality -= 5;
    } while (compressed.lengthInBytes > args.maxSizeKB * 1024 &&
        currentQuality > 10);

    return compressed;
  }
}

class _CompressImageArgs {
  final Uint8List bytes;
  final int maxSizeKB;
  final int quality;
  final String originalName;

  _CompressImageArgs({
    required this.bytes,
    required this.maxSizeKB,
    required this.quality,
    required this.originalName,
  });
}
