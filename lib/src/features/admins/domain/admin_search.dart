import 'package:dart_mappable/dart_mappable.dart';

part 'admin_search.mapper.dart';

@MappableClass()
class AdminSearch with AdminSearchMappable {
  final String? id;
  final String? name;

  AdminSearch({this.id, this.name});

  static fromMap(Map<String, dynamic> raw) {
    return AdminSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = AdminSearchMapper.fromMap;

  static AdminSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return AdminSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }
}
