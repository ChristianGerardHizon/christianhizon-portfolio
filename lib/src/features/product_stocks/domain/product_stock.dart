import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/core/hooks/date_time_hook.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';

part 'product_stock.mapper.dart';

@MappableClass()
class ProductStock extends PbRecord with ProductStockMappable {
  final String? lotNo;

  @MappableField(hook: DateTimeHook())
  final DateTime? expiration;
  final String? notes;
  final String product;
  final int? quantity;

  final bool isDisposed;

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
    this.quantity,
    this.isDisposed = false,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductStockMapper.fromMap(
      {
        ...raw,
        ProductStockField.expiration: raw[ProductStockField.expiration] == ''
            ? null
            : raw[ProductStockField.expiration],
      },
    );
  }

  static const fromJson = ProductStockMapper.fromJson;
}
