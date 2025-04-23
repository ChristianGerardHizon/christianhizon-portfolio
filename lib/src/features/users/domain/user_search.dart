import 'package:dart_mappable/dart_mappable.dart';

part 'user_search.mapper.dart';

@MappableClass()
class UserSearch with UserSearchMappable {
  final String? id;
  final String? name;

  UserSearch({this.id, this.name});

  static fromMap(Map<String, dynamic> raw) {
    return UserSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = UserSearchMapper.fromMap;

  static UserSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return UserSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }
}
