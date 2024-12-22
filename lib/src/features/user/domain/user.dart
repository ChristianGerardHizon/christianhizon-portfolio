import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String id;

  final String name;
  final String email;
  final String? avatar;
  final bool isDeleted;

  User({
    required this.id,
    required this.name,
    this.email = '',
    this.avatar,
    this.isDeleted = false,
  });

  static const fromMap = UserMapper.fromMap;
  static const fromJson = UserMapper.fromJson;

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;
}
