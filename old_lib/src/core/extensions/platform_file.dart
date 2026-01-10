import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

extension PlatformFileExtension on PlatformFile {
  /// convert to multipart file
  ///
  ///
  Future<http.MultipartFile> toMultipartFile(String key) async {
    if (this.path != null) {
      return await http.MultipartFile.fromPath(
        key,
        this.path!,
        filename: this.name,
      );
    } else if (this.bytes != null) {
      return await http.MultipartFile.fromBytes(
        key,
        this.bytes!,
        filename: this.name,
      );
    }
    throw 'missing path or bytes';
  }
}
