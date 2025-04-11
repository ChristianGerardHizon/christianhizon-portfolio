import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/strings/fields.dart';

part 'product_stock.mapper.dart';

@MappableClass()
class ProductStock extends PbRecord with ProductStockMappable {
  final String? lotNo;
  final DateTime? expiration;
  final String? notes;
  final String product;

  ProductStock({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required super.created,
    required super.isDeleted,
    required super.updated,

    ///
    ///
    ///
    required this.product,
    this.lotNo,
    this.expiration,
    this.notes,
  });

  static fromMap(Map<String, dynamic> raw) {
    try {
      return ProductStockMapper.fromMap(
        {
          ...raw,
          ProductStockField.expiration: raw[ProductStockField.expiration] == ''
              ? null
              : raw[ProductStockField.expiration],
        },
      );
    } catch (e) {
      throw 'Parse Failure $e';
    }
  }

  static const fromJson = ProductStockMapper.fromJson;
}
