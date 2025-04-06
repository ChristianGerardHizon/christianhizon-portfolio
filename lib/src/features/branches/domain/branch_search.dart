import 'package:dart_mappable/dart_mappable.dart';

part 'branch_search.mapper.dart';

@MappableClass()
class BranchSearch with BranchSearchMappable {
  final String? id;
  final String? name;

  BranchSearch({this.id, this.name});

  static const fromMap = BranchSearchMapper.fromMap;
  static const fromJson = BranchSearchMapper.fromMap;

  static BranchSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return BranchSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }

  static BranchSearch customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
