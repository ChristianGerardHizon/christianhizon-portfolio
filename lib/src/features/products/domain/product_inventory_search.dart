import 'package:dart_mappable/dart_mappable.dart';

part 'product_inventory_search.mapper.dart';

@MappableClass()
class ProductInventorySearch with ProductInventorySearchMappable {
  final String? id;
  final String? name;

  ProductInventorySearch({this.id, this.name});

  static fromMap(Map<String, dynamic> raw) {
    return ProductInventorySearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }
  static const fromJson = ProductInventorySearchMapper.fromMap;

  static ProductInventorySearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return ProductInventorySearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }
}
