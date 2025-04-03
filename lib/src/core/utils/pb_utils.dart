class PbUtils {
  static String imageBuilder({
    required String collection,
    required String id,
    required String fileName,
    required String domain,
  }) {
    return '$domain/api/files/$collection/$id/$fileName';
  }
}
