import 'package:dart_mappable/dart_mappable.dart';

part 'auth_user.mapper.dart';

@MappableClass()
class AuthUser with AuthUserMappable {
  final String id;
  final String token;

  final String collectionId;
  final String collectionName;
  final AuthUserType type;

  AuthUser({
    required this.id,
    required this.type,
    required this.collectionId,
    required this.collectionName,
    required this.token,
  });

  static const fromMap = AuthUserMapper.fromMap;
  static const fromJson = AuthUserMapper.fromJson;
}

@MappableEnum()
enum AuthUserType { admins, users }
