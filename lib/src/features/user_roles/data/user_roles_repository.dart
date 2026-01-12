import 'package:fpdart/fpdart.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/foundation/failure.dart';
import '../../../core/foundation/type_defs.dart';
import '../../../core/packages/pocketbase/pocketbase_collections.dart';
import '../../../core/packages/pocketbase/pocketbase_provider.dart';
import '../domain/user_role_entity.dart';
import 'user_role_dto.dart';

part 'user_roles_repository.g.dart';

/// Repository interface for user role operations.
abstract class UserRolesRepository {
  /// Fetches a user role by its ID.
  FutureEither<UserRoleEntity> fetchUserRole(String roleId);
}

/// Provides the UserRolesRepository instance.
@Riverpod(keepAlive: true)
UserRolesRepository userRolesRepository(Ref ref) {
  return UserRolesRepositoryImpl(ref.watch(pocketbaseProvider));
}

/// Implementation of [UserRolesRepository] using PocketBase.
class UserRolesRepositoryImpl implements UserRolesRepository {
  final PocketBase _pb;

  UserRolesRepositoryImpl(this._pb);

  RecordService get _collection =>
      _pb.collection(PocketBaseCollections.userRoles);

  @override
  FutureEither<UserRoleEntity> fetchUserRole(String roleId) async {
    return TaskEither.tryCatch(
      () async {
        if (roleId.isEmpty) {
          throw const DataFailure(
            'Role ID cannot be empty',
            null,
            'invalid_role_id',
          );
        }

        final record = await _collection.getOne(roleId);
        final dto = UserRoleDto.fromRecord(record);
        return dto.toEntity();
      },
      Failure.handle,
    ).run();
  }
}
