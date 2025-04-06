import 'package:dart_mappable/dart_mappable.dart';

part 'branch.mapper.dart';

@MappableClass()
class Branch with BranchMappable {
  final String id;

  final String name;

  final bool isDeleted;
  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;
  final String domain;

  Branch({
    required this.collectionId,
    required this.collectionName,
    required this.domain,
    required this.id,
    required this.name,
    this.isDeleted = false,
    required this.created,
    required this.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return BranchMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = BranchMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

}
