import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

@MappableClass()
class User with UserMappable {
  final String id;

  final String name;
  final String email;
  final String? profilePhoto;
  final bool isDeleted;

  User({
    required this.id,
    required this.name,
    this.email = '',
    this.profilePhoto,
    this.isDeleted = false,
  });

  static const fromMap = UserMapper.fromMap;
  static const fromJson = UserMapper.fromJson;

  bool get hasPicture => profilePhoto is String && profilePhoto!.isNotEmpty;
}
