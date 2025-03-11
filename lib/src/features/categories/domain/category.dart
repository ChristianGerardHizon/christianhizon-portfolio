import 'package:dart_mappable/dart_mappable.dart';

part 'category.mapper.dart';

@MappableClass()
class Category with CategoryMappable {
  final String id;

  final String name;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  Category({
    required this.id,
    required this.name,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static const fromMap = CategoryMapper.fromMap;
  static const fromJson = CategoryMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static Category customFromMap(Map<String, dynamic> raw) {
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
