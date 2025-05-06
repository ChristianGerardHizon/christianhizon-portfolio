import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/core/hooks/date_time_hook.dart';
import 'package:gym_system/src/core/hooks/pb_empty_hook.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/product_categories/domain/product_category.dart';

part 'product.mapper.dart';

@MappableClass()
class Product extends PbRecord with ProductMappable {
  final String name;
  final String? description;
  final String? category;
  final String? image;
  @MappableField(hook: PbEmptyHook())
  final String? branch;
  final num? stockThreshold;
  final num price;
  final bool forSale;

  final num? quantity;

  @MappableField(hook: DateTimeHook())
  final DateTime? expiration;

  final bool trackByLot;

  final ProductExpand expand;

  Product({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    required this.price,
    this.image,
    required this.forSale,
    this.description,
    this.category,
    this.branch,
    this.stockThreshold,
    required this.expand,
    super.isDeleted = false,
    super.created,
    super.updated,
    this.quantity,
    required this.trackByLot,
    this.expiration,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }

  bool get hasImage => image != null && image!.isNotEmpty;
}

@MappableClass()
class ProductExpand with ProductExpandMappable {
  final Branch? branch;
  final ProductCategory? category;

  ProductExpand({
    this.branch,
    this.category,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ProductExpandMapper.fromJson;
}
