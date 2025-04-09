import 'package:dart_mappable/dart_mappable.dart';

part 'product_inventory.mapper.dart';

@MappableEnum()
enum ProductStatus { inStock, outOfStock, lowStock, noThreshold }

@MappableClass()
class ProductInventory with ProductInventoryMappable {
  final String id;

  final String product;
  final ProductStatus status;
  final String name;
  final String? description;
  final String? category;
  final String? image;
  final String? branch;
  final String? branchName;

  final DateTime? created;
  final DateTime? updated;

  final bool isDeleted;
  final String collectionId;
  final String collectionName;

  ProductInventory({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.product,
    required this.status,
    required this.name,
    this.description,
    this.branchName,
    this.category,
    this.image,
    this.branch,
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
