import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';

part 'auth_user.mapper.dart';

@MappableClass()
class AuthUser extends AuthData with AuthUserMappable {
  final User record;

  static fromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
        'id': raw['record']['id'],
      },
    );
  }

  static const fromJson = AuthUserMapper.fromJson;

  AuthUser({
    required super.id,
    required super.token,
    required this.record,
    required super.collectionId,
    required super.collectionName,
  });
}
