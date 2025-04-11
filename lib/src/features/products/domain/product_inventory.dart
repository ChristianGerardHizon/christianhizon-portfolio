import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'product_inventory.mapper.dart';

@MappableEnum()
enum ProductStatus { inStock, outOfStock, lowStock, noThreshold }

@MappableClass()
class ProductInventory extends PbRecord with ProductInventoryMappable {
  final String product;
  final ProductStatus status;
  final String name;
  final String? description;
  final String? category;
  final String? image;
  final String? branch;
  final String? branchName;

  final int totalQuantity;
  final int totalQuantityAvailable;

  ProductInventory({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.product,
    required this.status,
    required this.name,
    this.description,
    this.category,
    this.image,
    this.branch,
    this.branchName,
    super.isDeleted = false,
    this.totalQuantity = 0,
    this.totalQuantityAvailable = 0,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductInventoryMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductInventoryMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
