import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../user_roles/presentation/controllers/user_roles_controller.dart';
import '../../data/auth_repository.dart';
import '../../domain/auth_state.dart';

part 'auth_controller.g.dart';

/// Controller for managing authentication state.
///
/// Provides methods for login, logout, and session management.
/// The state is [AuthState?] where null means not authenticated.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  Future<AuthState?> build() async {
    // Try to initialize from stored auth on app startup
    final result = await _repository.initialize();

    return result.fold(
      (failure) => null, // No valid auth, return null
      (authState) {
        // Fetch user role after restoring session
        _fetchUserRole(authState.user.id);
        return authState;
      },
    );
  }

  /// Attempts to login with email and password.
  ///
  /// Returns true on success, false on failure.
  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();

    final result = await _repository.login(email, password);

    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        return false;
      },
      (authState) {
        // Fetch user role after successful login
        _fetchUserRole(authState.user.id);
        state = AsyncData(authState);
        return true;
      },
    );
  }

  /// Logs out the current user.
  Future<void> logout() async {
    await _repository.logout();
    // Clear user role on logout
    ref.read(userRolesControllerProvider.notifier).clear();
    state = const AsyncData(null);
  }

  /// Refreshes the current authentication token.
  ///
  /// Returns true on success, false on failure.
  Future<bool> refresh() async {
    final result = await _repository.refresh();

    return result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        return false;
      },
      (authState) {
        // Refresh user role
        _fetchUserRole(authState.user.id);
        state = AsyncData(authState);
        return true;
      },
    );
  }

  /// Requests a password reset email.
  Future<bool> requestPasswordReset(String email) async {
    final result = await _repository.requestPasswordReset(email);
    return result.isRight();
  }

  /// Requests email verification.
  Future<bool> requestVerification(String email) async {
    final result = await _repository.requestVerification(email);
    return result.isRight();
  }

  /// Fetches the user role from the user_roles collection.
  void _fetchUserRole(String? userId) {
    if (userId != null && userId.isNotEmpty) {
      ref.read(userRolesControllerProvider.notifier).fetchRole(userId);
    }
  }
}

/// Convenience provider to check if user is authenticated.
@Riverpod(keepAlive: true)
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(authControllerProvider);
  return authState.value != null;
}

/// Convenience provider to get the current user.
@Riverpod(keepAlive: true)
AuthState? currentAuth(Ref ref) {
  return ref.watch(authControllerProvider).value;
}
