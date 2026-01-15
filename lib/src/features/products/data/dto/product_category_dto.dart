import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../domain/product_category.dart';

part 'product_category_dto.mapper.dart';

/// Data Transfer Object for ProductCategory from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain ProductCategory.
@MappableClass()
class ProductCategoryDto with ProductCategoryDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? parent;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const ProductCategoryDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.parent,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory ProductCategoryDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Get expanded parent name using the get<T>() method
    final parentExpanded = record.get<String>('expand.parent.name');
    final parentName = parentExpanded.isNotEmpty ? parentExpanded : null;

    return ProductCategoryDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      parent: parentName ?? json['parent'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain ProductCategory entity.
  ProductCategory toEntity() {
    return ProductCategory(
      id: id,
      name: name,
      parentId: parent,
      parentName: parent,
      isDeleted: isDeleted,
      created: created != null ? DateTime.tryParse(created!) : null,
      updated: updated != null ? DateTime.tryParse(updated!) : null,
    );
  }
}
