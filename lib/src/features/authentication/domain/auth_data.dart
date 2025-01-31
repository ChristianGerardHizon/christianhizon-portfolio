import 'package:dart_mappable/dart_mappable.dart';

part 'auth_data.mapper.dart';

@MappableEnum()
enum AuthDataType { admins, users }

@MappableClass()
abstract class AuthData with AuthDataMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String token;

  AuthData({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.token,
  });

  AuthDataType get type {
    switch (collectionId) {
      case 'admins':
        return AuthDataType.admins;
      default:
        return AuthDataType.users;
    }
  }

  static const fromMap = AuthDataMapper.fromMap;
  static const fromJson = AuthDataMapper.fromJson;

  static AuthData customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
        'id': raw['record']['id'],
        'collectionId': raw['record']['collectionId'],
      },
    );
  }
}
