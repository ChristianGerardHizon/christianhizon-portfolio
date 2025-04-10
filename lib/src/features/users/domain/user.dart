import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_record.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';

part 'user.mapper.dart';

@MappableClass()
class User extends PbRecord with UserMappable {
  final String name;
  final String email;
  final String? avatar;
  final bool verified;

  User({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    this.name = '',
    this.email = '',
    this.avatar,
    this.verified = false,
    super.isDeleted = false,
    super.created,
    super.updated,
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
