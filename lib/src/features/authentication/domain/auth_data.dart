import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_user.dart';

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
    switch (collectionName) {
      case PocketBaseCollections.admins:
        return AuthDataType.admins;
      default:
        return AuthDataType.users;
    }
  }

  static fromMap(Map<String, dynamic> raw) {
    return AuthDataMapper.fromMap(
      {
        ...raw,
        'id': raw['record']['id'],
        'collectionId': raw['record']['collectionId'],
      },
    );
  }

  static const fromJson = AuthDataMapper.fromJson;

  /*

     final email = user.map(
                (u) => u.record.email,
                (a) => a.record.email,
              );

  */

  /// maps AuthData to a value of type R
  /// if this is of type users, calls [onUser] with the user record
  /// if this is of type admins, calls [onAdmin] with the admin record
  R map<R>(
    R Function(AuthUser user) onUser,
    R Function(AuthAdmin admin) onAdmin,
  ) {
    switch (type) {
      case AuthDataType.users:
        return onUser(this as AuthUser);
      case AuthDataType.admins:
        return onAdmin(this as AuthAdmin);
    }
  }
}
