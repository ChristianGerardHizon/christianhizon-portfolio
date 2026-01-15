import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sannjosevet/src/features/auth/presentation/controllers/auth_controller.dart';

import '../../data/user_roles_repository.dart';
import '../../domain/user_role_entity.dart';

part 'user_roles_controller.g.dart';

/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.
@Riverpod(keepAlive: true)
class UserRolesController extends _$UserRolesController {
  UserRolesRepository get _repository => ref.read(userRolesRepositoryProvider);

  @override
  Future<UserRoleEntity?> build(String id) async {
    final result = await _repository.fetchUserRole(id);

    return result.fold(
      (failure) => null,
      (role) => role,
    );
  }

  /// Clears the stored user role.
  void clear() {
    state = const AsyncData(null);
  }
}

/// Convenience provider that returns whether the current user is an admin.
@riverpod
bool isAdmin(Ref ref) {
  final id =
      ref.watch(authControllerProvider.select((auth) => auth.value?.user.id));
  if (id == null) {
    return false;
  }
  final roleAsync = ref.watch(userRolesControllerProvider(id));
  return switch (roleAsync) {
    AsyncData(:final value) => value?.isAdmin ?? false,
    _ => false,
  };
}
