import 'package:dart_mappable/dart_mappable.dart';

part 'product_category.mapper.dart';

@MappableClass()
class ProductCategory with ProductCategoryMappable {
  final String id;

  final String name;
  final String? parent;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  ProductCategory({
    required this.id,
    required this.name,
    this.parent,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductCategoryMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductCategoryMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }
}
