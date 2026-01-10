import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_record.dart';
import 'package:sannjosevet/src/core/hooks/pb_empty_hook.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';

part 'user.mapper.dart';

@MappableClass()
class User extends PbRecord with UserMappable {
  final String name;
  final String email;
  final String? avatar;
  final bool verified;
  @MappableField(hook: PbEmptyHook())
  final String? branch;

  final UserExpand expand;

  User({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    this.branch,
    this.name = '',
    this.email = '',
    this.avatar,
    this.verified = false,
    super.isDeleted = false,
    super.created,
    super.updated,
    required this.expand,
  });

  static fromMap(Map<String, dynamic> raw) {
    return UserMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = UserMapper.fromJson;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': updated,
    };
  }

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;

  Uri? avatarUri(String domain) {
    if (avatar == null || avatar!.isEmpty) return null;
    return PBUtils.imageBuilder(
      collection: collectionId,
      id: id,
      domain: domain,
      fileName: avatar!,
    );
  }
}

@MappableClass()
class UserExpand with UserExpandMappable {
  final Branch? branch;

  UserExpand({
    this.branch,
  });

  static fromMap(Map<String, dynamic> raw) {
    return UserExpandMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = UserExpandMapper.fromJson;
}
