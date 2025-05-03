import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'product_category.mapper.dart';

@MappableClass()
class ProductCategory extends PbRecord with ProductCategoryMappable {
  final String name;
  final String? parent;

  ProductCategory({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.parent,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductCategoryMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductCategoryMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
