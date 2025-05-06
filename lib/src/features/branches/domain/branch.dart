import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_record.dart';

part 'branch.mapper.dart';

@MappableClass()
class Branch extends PbRecord with BranchMappable {
  final String name;

  Branch({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return BranchMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = BranchMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}
