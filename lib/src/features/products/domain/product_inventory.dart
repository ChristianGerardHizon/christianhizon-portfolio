import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_category.dart';

part 'product_inventory.mapper.dart';

@MappableEnum()
enum ProductStatus { inStock, outOfStock, lowStock, noThreshold }

@MappableClass()
class ProductInventory extends PbRecord with ProductInventoryMappable {
  final String product;
  final ProductStatus status;

  final ProductInventoryExpand expand;

  final num totalQuantity;
  final num totalQuantityAvailable;
  final num totalExpired;

  ProductInventory({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.product,
    required this.status,
    required this.expand,
    this.totalExpired = 0,
    this.totalQuantity = 0,
    this.totalQuantityAvailable = 0,
    super.isDeleted = false,
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

@MappableClass()
class ProductInventoryExpand with ProductInventoryExpandMappable {
  final Product product;
  final Branch? branch;
  final ProductCategory? category;

  ProductInventoryExpand({
    required this.product,
    this.branch,
    this.category,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductInventoryExpand.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductInventoryExpandMapper.fromJson;
}
