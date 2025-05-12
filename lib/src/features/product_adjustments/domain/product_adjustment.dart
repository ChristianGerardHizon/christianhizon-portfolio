import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';

part 'product_adjustment.mapper.dart';

@MappableEnum()
enum ProductAdjustmentType { product, productStock }

@MappableClass(discriminatorKey: 'type')
abstract class ProductAdjustment extends PbRecord
    with ProductAdjustmentMappable {
  final String? reason;
  final ProductAdjustmentType type;
  final num oldValue;
  final num newValue;

  ProductAdjustment({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    required this.oldValue,
    required this.newValue,
    required this.type,
    this.reason,
  });

  static fromMap(Map<String, dynamic> raw) {
    if (raw['type'] == ProductAdjustmentType.product.name) {
      return ProductAdjustmentSimple.fromMap(raw);
    } else if (raw['type'] == ProductAdjustmentType.productStock.name) {
      return ProductAdjustmentStock.fromMap(raw);
    }
    throw Exception('Invalid type current value: (${raw['type']})');
  }

  static const fromJson = ProductAdjustmentMapper.fromJson;
}

@MappableClass(discriminatorValue: ProductAdjustmentType.product)
class ProductAdjustmentSimple extends ProductAdjustment
    with ProductAdjustmentSimpleMappable {
  final String product;
  final ProductAdjustmentSimpleExpand expand;

  ProductAdjustmentSimple({
    required this.product,
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    required super.oldValue,
    required super.newValue,
    required this.expand,
    super.reason,
  }) : super(type: ProductAdjustmentType.product);

  static const fromMap = ProductAdjustmentSimpleMapper.fromMap;
  static const fromJson = ProductAdjustmentSimpleMapper.fromJson;
}

@MappableClass()
class ProductAdjustmentSimpleExpand with ProductAdjustmentSimpleExpandMappable {
  final Product? product;

  ProductAdjustmentSimpleExpand({this.product});

  static fromMap(Map<String, dynamic> raw) =>
      ProductAdjustmentSimpleExpandMapper.fromMap(raw);
  static const fromJson = ProductAdjustmentSimpleExpandMapper.fromJson;
}

@MappableClass(discriminatorValue: ProductAdjustmentType.productStock)
class ProductAdjustmentStock extends ProductAdjustment
    with ProductAdjustmentStockMappable {
  final String productStock;
  final ProductAdjustmentStockExpand expand;

  ProductAdjustmentStock({
    required this.productStock,
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
    required super.oldValue,
    required super.newValue,
    required this.expand,
    super.reason,
  }) : super(type: ProductAdjustmentType.productStock);

  static const fromMap = ProductAdjustmentStockMapper.fromMap;
  static const fromJson = ProductAdjustmentStockMapper.fromJson;
}

@MappableClass()
class ProductAdjustmentStockExpand with ProductAdjustmentStockExpandMappable {
  final ProductStock productStock;

  ProductAdjustmentStockExpand({required this.productStock});

  static fromMap(Map<String, dynamic> raw) =>
      ProductAdjustmentStockExpandMapper.fromMap(raw);
  static const fromJson = ProductAdjustmentStockExpandMapper.fromJson;
}
