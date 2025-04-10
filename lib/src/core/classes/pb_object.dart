import 'package:dart_mappable/dart_mappable.dart';

part 'pb_object.mapper.dart';

@MappableClass()
abstract class PbObject with PbObjectMappable {
  final String id;
  final DateTime? created;
  final DateTime? updated;

  final bool isDeleted;
  final String collectionId;
  final String collectionName;

  PbObject({
    required this.id,
    required this.isDeleted,
    required this.collectionId,
    required this.collectionName,
    this.created,
    this.updated,
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
