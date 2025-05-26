import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/core/hooks/pb_empty_hook.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';

part 'admin.mapper.dart';

@MappableClass()
class Admin extends PbRecord with AdminMappable {
  final String name;
  final String email;
  final String? avatar;
  final bool verified;
  @MappableField(hook: PbEmptyHook())
  final String? branch;
  final AdminExpand expand;

  Admin({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.branch,
    this.email = '',
    this.avatar,
    this.verified = false,
    super.isDeleted = false,
    super.created,
    super.updated,
    required this.expand,
  });

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }

  static const fromMap = AdminMapper.fromMap;
  static const fromJson = AdminMapper.fromJson;

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;

  Uri? avatarUri(String domain) {
    if (avatar == null || avatar!.isEmpty) return null;
    return Uri.tryParse('$domain/$collectionId/$avatar');
  }
}

@MappableClass()
class AdminExpand with AdminExpandMappable {
  final Branch? branch;

  AdminExpand({
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AdminExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = AdminExpandMapper.fromJson;
}
