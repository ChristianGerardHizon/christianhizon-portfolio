import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_data.dart';

part 'auth_admin.mapper.dart';

@MappableClass()
class AuthAdmin extends AuthData with AuthAdminMappable {
  final Admin record;

  static const fromMap = AuthAdminMapper.fromMap;
  static const fromJson = AuthAdminMapper.fromJson;

  AuthAdmin({
    required super.id,
    required super.token,
    required this.record,
    required super.collectionId,
    required super.collectionName,
  });

  static AuthAdmin customFromMap(Map<String, dynamic> raw) {
    // if dateOfBirth is '' empty string, it will be null
    return fromMap(
      {
        ...raw,
        'id': raw['record']['id'],
      },
    );
  }
}
