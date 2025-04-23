import 'package:dart_mappable/dart_mappable.dart';

part 'product_stock_search.mapper.dart';

@MappableClass()
class ProductStockSearch with ProductStockSearchMappable {
  final String? id;
  final String? name;
  final DateTime? expiration;

  ProductStockSearch({
    this.id,
    this.name,
    this.expiration,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ProductStockSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = ProductStockSearchMapper.fromMap;

  static ProductStockSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
    DateTime? expiration,
  }) {
    return ProductStockSearch(
      id: id ? query : null,
      name: name ? query : null,
      expiration: expiration,
    );
  }
}
