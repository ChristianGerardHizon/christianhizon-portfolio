import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/product.dart';

part 'product_dto.mapper.dart';

/// Data Transfer Object for Product from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Product.
@MappableClass()
class ProductDto with ProductDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? description;
  final String? category;
  final String? image;
  final String? branch;
  final num? stockThreshold;
  final num price;
  final bool forSale;
  final num? quantity;
  final String? expiration;
  final bool trackByLot;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const ProductDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.description,
    this.category,
    this.image,
    this.branch,
    this.stockThreshold,
    this.price = 0,
    this.forSale = true,
    this.quantity,
    this.expiration,
    this.trackByLot = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory ProductDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Get expanded category name using the get<T>() method
    final categoryExpanded = record.get<String>('expand.category.name');
    final categoryName = categoryExpanded.isNotEmpty ? categoryExpanded : null;

    return ProductDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      category: categoryName ?? json['category'] as String?,
      image: json['image'] as String?,
      branch: json['branch'] as String?,
      stockThreshold: json['stockThreshold'] as num?,
      price: json['price'] as num? ?? 0,
      forSale: json['forSale'] as bool? ?? true,
      quantity: json['quantity'] as num?,
      expiration: json['expiration'] as String?,
      trackByLot: json['trackByLot'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain Product entity.
  Product toEntity({String? baseUrl}) {
    return Product(
      id: id,
      name: name,
      description: description,
      categoryId: category,
      categoryName: category,
      image: _buildImageUrl(baseUrl),
      branch: branch,
      stockThreshold: stockThreshold,
      price: price,
      forSale: forSale,
      quantity: quantity,
      expiration: expiration != null ? DateTime.tryParse(expiration!) : null,
      trackByLot: trackByLot,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }

  String? _buildImageUrl(String? baseUrl) {
    if (image == null || image!.isEmpty || baseUrl == null) return null;
    return '$baseUrl/api/files/$collectionName/$id/$image';
  }
}
