import 'package:dart_mappable/dart_mappable.dart';

part 'product_category.mapper.dart';

/// ProductCategory domain model.
///
/// Represents a product category with optional hierarchical parent.
@MappableClass()
class ProductCategory with ProductCategoryMappable {
  const ProductCategory({
    required this.id,
    required this.name,
    this.parentId,
    this.parentName,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// PocketBase record ID.
  final String id;

  /// Category name.
  final String name;

  /// Parent category FK ID (for hierarchy).
  final String? parentId;

  /// Parent category name (expanded from FK).
  final String? parentName;

  /// Soft delete flag.
  final bool isDeleted;

  /// Creation timestamp.
  final DateTime? created;

  /// Last update timestamp.
  final DateTime? updated;

  /// Returns true if this category has a parent.
  bool get hasParent => parentId != null && parentId!.isNotEmpty;
}
