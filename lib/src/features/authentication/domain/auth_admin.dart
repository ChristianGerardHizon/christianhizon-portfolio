import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/features/admins/domain/admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';

part 'auth_admin.mapper.dart';

@MappableClass()
class AuthAdmin extends AuthData with AuthAdminMappable {
  final Admin record;

  static fromMap(Map<String, dynamic> raw) {
    return AuthAdminMapper.fromMap(
      {
        ...raw,
        'id': raw['record']['id'],
      },
    );
  }

  static const fromJson = AuthAdminMapper.fromJson;

  AuthAdmin({
    required super.id,
    required super.token,
    required this.record,
    required super.collectionId,
    required super.collectionName,
  });
}
