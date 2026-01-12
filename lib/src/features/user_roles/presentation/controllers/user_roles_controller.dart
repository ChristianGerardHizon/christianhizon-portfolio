import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  Future<UserRoleEntity?> build() async {
    return null;
  }

  /// Fetches the user role by ID and stores it in state.
  ///
  /// Returns `true` if the role was fetched successfully, `false` otherwise.
  Future<bool> fetchRole(String? roleId) async {
    if (roleId == null || roleId.isEmpty) {
      state = const AsyncData(null);
      return false;
    }

    state = const AsyncLoading();

    final result = await _repository.fetchUserRole(roleId);

    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        return false;
      },
      (role) {
        state = AsyncData(role);
        return true;
      },
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
  final roleAsync = ref.watch(userRolesControllerProvider);
  return switch (roleAsync) {
    AsyncData(:final value) => value?.isAdmin ?? false,
    _ => false,
  };
}
