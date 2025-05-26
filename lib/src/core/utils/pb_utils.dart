import 'package:sannjosevet/src/core/models/pb_file.dart';
import 'package:http/http.dart';

class PBUtils {
  static Uri? imageBuilder({
    required String collection,
    required String id,
    required String fileName,
    required String domain,
  }) {
    return Uri.tryParse('$domain/api/files/$collection/$id/$fileName');
  }

  ///
  /// PBImage Handlers
  ///
  static dynamic defaultFieldTransformer(
    List<PBFile>? list, {
    bool isSingleFile = true,
  }) {
    final value = [...list ?? []];
    final result = value.where((x) => x.isUpdate).map((x) {
      if (x is PBNetworkFile) return x.fileName;
      return x.id;
    });
    if (isSingleFile) return result.firstOrNull;
    return result.toList();
  }

  static List<Future<MultipartFile>> defaultFileTransformer(list) {
    final value = [...list ?? []];
    return value
        .where((x) => x.isCreate)
        .map((x) => x.toMultipart())
        .whereType<Future<MultipartFile>>()
        .toList();
  }

  static Future<(Map<String, dynamic>, List<MultipartFile>)> transformForm(
    Map<String, dynamic> values,
  ) async {
    final fields = <String, dynamic>{};
    final files = <MultipartFile>[];

    // iterate through values
    for (final entry in values.entries) {
      final key = entry.key;
      final value = entry.value;

      ///
      /// PBIMAGE
      ///
      if (value is List<PBFile>) {
        final pbImageFields = value.where((x) => x.isUpdate).map((x) => x.id);
        fields[key] = pbImageFields.toList();

        final pbImageFiles = value.where((x) => x.isCreate).map((x) async {
          return x.toMultipart();
        }).toList();

        try {
          final filesFuture = await Future.wait(pbImageFiles);
          files.addAll(filesFuture);
        } catch (e) {
          print(e.toString());
        }
      }
    }
    return (fields, files);
  }
}
