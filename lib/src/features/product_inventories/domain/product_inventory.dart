import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/product_categories/domain/product_category.dart';
import 'package:sannjosevet/src/features/products/domain/product.dart';

part 'product_inventory.mapper.dart';

@MappableEnum()
enum ProductStatus { inStock, outOfStock, lowStock, noThreshold }

@MappableClass()
class ProductInventory extends PbRecord with ProductInventoryMappable {
  final String product;
  final ProductStatus status;

  final ProductInventoryExpand expand;

  final num totalQuantity;
  final num totalExpired;
  final bool forSale;

  ProductInventory({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.product,
    required this.status,
    required this.expand,
    this.totalExpired = 0,
    this.totalQuantity = 0,
    this.forSale = false,
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

  ProductInventoryExpand({
    required this.product,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductInventoryExpand.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductInventoryExpandMapper.fromJson;
}
