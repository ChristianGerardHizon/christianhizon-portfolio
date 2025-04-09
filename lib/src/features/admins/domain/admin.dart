import 'package:dart_mappable/dart_mappable.dart';

part 'admin.mapper.dart';

@MappableClass()
class Admin with AdminMappable {
  final String id;

  final String name;
  final String email;
  final String? avatar;
  final bool isDeleted;
  final bool verified;

  final DateTime? created;
  final DateTime? updated;

  final String collectionId;
  final String collectionName;

  Admin({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.name,
    this.email = '',
    this.avatar,
    this.isDeleted = false,
    this.verified = false,
    this.created,
    this.updated,
  });

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
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
