import 'package:cross_file/cross_file.dart';
import 'package:mime/mime.dart';

extension XFileExtension on XFile {
  bool get isImageFile {
    final file = this;
    // Look up the MIME type based on the file extension
    final mimeType = lookupMimeType(file.path);

    // If we couldn’t determine it, assume it’s not an image
    if (mimeType == null) return false;

    // An image MIME type always starts with 'image/'
    return mimeType.startsWith('image/');
  }
}
