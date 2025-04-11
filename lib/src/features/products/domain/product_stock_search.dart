import 'package:dart_mappable/dart_mappable.dart';

part 'product_stock_search.mapper.dart';

@MappableClass()
class ProductStockSearch with ProductStockSearchMappable {
  final String? id;
  final String? name;

  ProductStockSearch({this.id, this.name});

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
  }) {
    return ProductStockSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }
}
