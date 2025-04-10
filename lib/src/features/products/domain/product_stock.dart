import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_object.dart';

part 'product_stock.mapper.dart';

@MappableClass()
class ProductStock extends PbObject with ProductStockMappable {
  ProductStock({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required super.created,
    required super.isDeleted,
    required super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PbObjectMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PbObjectMapper.fromJson;
}
