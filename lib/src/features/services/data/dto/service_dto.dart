import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/service.dart';

part 'service_dto.mapper.dart';

/// Data Transfer Object for Service from PocketBase.
///
/// Handles conversion between PocketBase RecordModel and domain Service.
@MappableClass()
class ServiceDto with ServiceDtoMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String? description;
  final String? category;
  final String? categoryName;
  final String? branch;
  final num price;
  final bool isVariablePrice;
  final num? estimatedDuration;
  final bool weightBased;
  final bool isDeleted;
  final String? created;
  final String? updated;

  const ServiceDto({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.name,
    this.description,
    this.category,
    this.categoryName,
    this.branch,
    this.price = 0,
    this.isVariablePrice = false,
    this.estimatedDuration,
    this.weightBased = false,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  /// Creates a DTO from a PocketBase RecordModel.
  factory ServiceDto.fromRecord(RecordModel record) {
    final json = record.toJson();

    // Get expanded category name
    final categoryExpanded = record.get<String>('expand.category.name');
    final categoryName = categoryExpanded.isNotEmpty ? categoryExpanded : null;

    return ServiceDto(
      id: json['id'] as String? ?? '',
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      category: json['category'] as String?,
      categoryName: categoryName,
      branch: json['branch'] as String?,
      price: json['price'] as num? ?? 0,
      isVariablePrice: json['isVariablePrice'] as bool? ?? false,
      estimatedDuration: json['estimatedDuration'] as num?,
      weightBased: json['weightBased'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
    );
  }

  /// Converts the DTO to a domain Service entity.
  Service toEntity() {
    return Service(
      id: id,
      name: name,
      description: description,
      categoryId: category,
      categoryName: categoryName,
      branch: branch,
      price: price,
      isVariablePrice: isVariablePrice,
      estimatedDuration: estimatedDuration,
      weightBased: weightBased,
      isDeleted: isDeleted,
      created: parseToLocal(created),
      updated: parseToLocal(updated),
    );
  }
}
