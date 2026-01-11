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
  @override
  Future<UserRoleEntity?> build() async {
    return null;
  }

  /// Fetches the user role by ID and stores it in state.
  Future<void> fetchRole(String? roleId) async {
    if (roleId == null || roleId.isEmpty) {
      state = const AsyncData(null);
      return;
    }

    state = const AsyncLoading();

    final repository = ref.read(userRolesRepositoryProvider);
    final role = await repository.fetchUserRole(roleId);

    state = AsyncData(role);
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
