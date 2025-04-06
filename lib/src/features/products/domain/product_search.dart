import 'package:dart_mappable/dart_mappable.dart';

part 'product_search.mapper.dart';

@MappableClass()
class ProductSearch with ProductSearchMappable {
  final String? id;
  final String? name;

  ProductSearch({this.id, this.name});

  static fromMap(Map<String, dynamic> raw) {
    return ProductSearchMapper.fromMap(
      {
        ...raw,
      },
    );
  }  static const fromJson = ProductSearchMapper.fromMap;

  static ProductSearch buildQuery(
    String query, {
    bool id = false,
    bool name = false,
  }) {
    return ProductSearch(
      id: id ? query : null,
      name: name ? query : null,
    );
  }

}
