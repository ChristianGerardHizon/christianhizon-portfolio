import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../domain/user_role_entity.dart';
import 'user_role_dto.dart';

part 'user_roles_repository.g.dart';

/// Provides the UserRolesRepository instance.
@riverpod
UserRolesRepository userRolesRepository(Ref ref) {
  return UserRolesRepository(ref.watch(pocketbaseProvider));
}

/// Repository for fetching user roles from PocketBase.
class UserRolesRepository {
  final PocketBase _pb;

  static const String _collection = 'user_roles';

  UserRolesRepository(this._pb);

  /// Fetches a user role by its ID.
  ///
  /// Returns null if the role is not found or if roleId is empty.
  Future<UserRoleEntity?> fetchUserRole(String? roleId) async {
    if (roleId == null || roleId.isEmpty) {
      return null;
    }

    try {
      final record = await _pb.collection(_collection).getOne(roleId);
      final dto = UserRoleDto.fromRecord(record);
      return dto.toEntity();
    } catch (e) {
      // Role not found or other error
      return null;
    }
  }
}
