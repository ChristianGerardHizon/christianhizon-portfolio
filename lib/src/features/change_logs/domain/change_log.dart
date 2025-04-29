import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';

part 'change_log.mapper.dart';

@MappableClass()
class ChangeLog extends PbRecord with ChangeLogMappable {
  final String? message;
  final String? user;
  final String? admin;

  final dynamic change;
  final ChangeLogType type;

  ChangeLog({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    required this.type,
    this.message,
    super.created,
    super.updated,
    this.user,
    this.admin,
    this.change,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ChangeLogMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = ChangeLogMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }
}

@MappableEnum()
enum ChangeLogType {
  created,
  updated,
  deleted,
}
