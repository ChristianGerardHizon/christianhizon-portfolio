import 'package:dart_mappable/dart_mappable.dart';

part 'product.mapper.dart';

@MappableClass()
class Product with ProductMappable {
  final String id;

  final String name;
  final String? category;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  Product({
    required this.id,
    required this.name,
    this.category,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static const fromMap = ProductMapper.fromMap;
  static const fromJson = ProductMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static Product customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
