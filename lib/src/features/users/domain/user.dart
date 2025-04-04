import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final bool verified;

  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;
  final String domain;

  User({
    required this.domain,
    required this.collectionId,
    required this.collectionName,
    required this.id,
    this.name = '',
    this.email = '',
    this.created,
    this.updated,
    this.avatar,
    this.verified = false,
  });

  // static const fromMap = UserMapper.fromMap;
  static fromMap(Map<String, dynamic> raw) {
    return UserMapper.fromMap(
      {
        ...raw,
      },
    );
  }

  static const fromJson = UserMapper.fromMap;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;

  Uri? get avatarUri {
    if (avatar == null || avatar!.isEmpty) return null;
    return PBUtils.imageBuilder(
      collection: collectionId,
      id: id,
      domain: domain,
      fileName: avatar!,
    );
  }
}
