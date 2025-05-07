import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';

part 'product_stock_adjustment.mapper.dart';

@MappableClass()
class ProductStockAdjustment extends PbRecord
    with ProductStockAdjustmentMappable {
  final String? reason;
  final num oldValue;
  final num newValue;
  final String? productStock;
  final String? product;

  ProductStockAdjustment({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,

    ///
    ///
    required this.oldValue,
    required this.productStock,
    required this.product,
    required this.newValue,
    this.reason,
  });

  static const fromMap = ProductStockAdjustmentMapper.fromMap;
  static const fromJson = ProductStockAdjustmentMapper.fromJson;
}
