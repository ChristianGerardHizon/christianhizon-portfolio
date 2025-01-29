import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String id;

  final String name;
  final String email;
  final String? avatar;
  final bool isDeleted;

  final DateTime? created;
  final DateTime? updated;

  User({
    required this.id,
    required this.name,
    this.email = '',
    this.avatar,
    this.isDeleted = false,
    this.created,
    this.updated,
  });

  static const fromMap = UserMapper.fromMap;
  static const fromJson = UserMapper.fromJson;

  bool get hasAvatar => avatar is String && avatar!.isNotEmpty;

  Map<String, dynamic> toForm() {
    return {
      ...toMap(),
      'created': created,
      'updated': created,
    };
  }

  static User customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
      },
    );
  }
}
