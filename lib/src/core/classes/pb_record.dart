import 'package:dart_mappable/dart_mappable.dart';

part 'pb_record.mapper.dart';

@MappableClass()
abstract class PbRecord with PbRecordMappable {
  final String id;
  final DateTime? created;
  final DateTime? updated;

  final bool isDeleted;
  final String collectionId;
  final String collectionName;

  PbRecord({
    required this.id,
    required this.isDeleted,
    required this.collectionId,
    required this.collectionName,
    this.created,
    this.updated,
  });
}
