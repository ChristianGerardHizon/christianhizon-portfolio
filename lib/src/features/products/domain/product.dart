import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';

part 'product.mapper.dart';

@MappableClass()
class Product with ProductMappable {
  final String id;

  final String name;
  final String? notes;
  final String? category;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  final String? image;
  final String? branch;

  final String collectionId;
  final String collectionName;
  final String domain;

  final ProductExpand expand;

  Product({
    required this.collectionId,
    required this.collectionName,
    required this.domain,
    required this.id,
    required this.name,
    this.image,
    this.notes,
    this.category,
    this.branch,
    required this.expand,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return ProductMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  bool get hasImage => image != null && image!.isNotEmpty;
  Uri? get imageUri {
    if (!hasImage) return null;
    return PBUtils.imageBuilder(
      collection: collectionId,
      id: id,
      domain: domain,
      fileName: image!,
    );
  }
}

@MappableClass()
class ProductExpand with ProductExpandMappable {
  final Branch? branch;

  ProductExpand({
    this.branch,
  });

    static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return ProductExpandMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductExpandMapper.fromMap;
}
