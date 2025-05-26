import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/features/admins/domain/admin.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';

part 'change_log.mapper.dart';

@MappableClass()
class ChangeLog extends PbRecord with ChangeLogMappable {
  final String collection;
  final String reference;

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
    required this.collection,
    required this.reference,
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

@MappableClass()
class ChangeLogExpand with ChangeLogExpandMappable {
  final User? user;
  final Admin? admin;

  ChangeLogExpand({
    this.user,
    this.admin,
  });

  static fromMap(Map<String, dynamic> raw) {
    return ChangeLogExpand.fromMap({
      ...raw,
    });
  }

  static const fromJson = ChangeLogExpandMapper.fromJson;
}

@MappableEnum()
enum ChangeLogType {
  create,
  update,
  delete,
}
