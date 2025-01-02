import 'package:dart_mappable/dart_mappable.dart';

part 'admin.mapper.dart';

@MappableClass()
class Admin with AdminMappable {
  final String id;

  final String name;
  final String email;
  final String? avatar;
  final bool isDeleted;

  Admin({
    required this.id,
    required this.name,
    this.email = '',
    this.avatar,
    this.isDeleted = false,
  });

  static const fromMap = AdminMapper.fromMap;
  static const fromJson = AdminMapper.fromJson;

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;
}

