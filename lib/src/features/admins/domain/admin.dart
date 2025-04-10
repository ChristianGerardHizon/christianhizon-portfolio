import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_object.dart';

part 'admin.mapper.dart';

@MappableClass()
class Admin extends PbObject with AdminMappable {
  final String name;
  final String email;
  final String? avatar;
  final bool verified;

  Admin({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required this.name,
    this.email = '',
    this.avatar,
    this.verified = false,
    super.isDeleted = false,
    super.created,
    super.updated,
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
