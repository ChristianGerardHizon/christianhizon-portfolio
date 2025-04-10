import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_object.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';

part 'product.mapper.dart';

@MappableClass()
class Product extends PbObject with ProductMappable {
  final String name;
  final String? description;
  final String? category;
  final String? image;
  final String? branch;
  final int? stockThreshold;

  final ProductExpand expand;

  Product({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.image,
    this.description,
    this.category,
    this.branch,
    this.stockThreshold,
    required this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }

  bool get hasImage => image != null && image!.isNotEmpty;
}

@MappableClass()
class ProductExpand with ProductExpandMappable {
  final Branch? branch;

  ProductExpand({
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductExpandMapper.fromJson;
}
