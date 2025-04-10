import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'product_stock.mapper.dart';

@MappableClass()
class ProductStock extends PbRecord with ProductStockMappable {
  ProductStock({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required super.created,
    required super.isDeleted,
    required super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PbRecordMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = PbRecordMapper.fromJson;
}
