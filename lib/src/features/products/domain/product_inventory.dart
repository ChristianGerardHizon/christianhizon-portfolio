import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/features/products/domain/product.dart';

part 'product_inventory.mapper.dart';


@MappableEnum()
enum ProductStatus {
  inStock,
  outOfStock,
  lowStock
}


@MappableClass()
class ProductInventory with ProductInventoryMappable {
  final String id;

  final String product;
  final ProductStatus status;

  final DateTime? created;
  final DateTime? updated;

  final bool isDeleted;
  final String collectionId;
  final String collectionName;
  final String domain;

  final ProductInventoryExpand? expand;

  ProductInventory({
    required this.collectionId,
    required this.collectionName,
    required this.domain,
    required this.id,
    required this.product,
    required this.status,
    required this.expand,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return ProductInventoryMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductInventoryMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }
}

@MappableClass()
class ProductInventoryExpand with ProductInventoryExpandMappable {
  final Product product;

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return ProductInventoryExpandMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductInventoryExpandMapper.fromMap;

  ProductInventoryExpand({
    required this.product,
  });
}
