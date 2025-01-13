import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/data/auth_repository.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  ///
  /// default no user failure
  ///
  final _noUserFailure = Failure.presentation('User not found');

  @override
  Future<AuthUser> build() async {
    final result = await ref
        .read(authRepositoryProvider)
        .initialize()
        .run()
        .timeout(const Duration(minutes: 1));

    return result.fold(
      (l) {
        ref.read(authRepositoryProvider).logout();
        throw l;
      },
      (user) async {
        return user;
      },
    );
  }

  TaskResult<AuthUser> setUser(AuthUser? user) {
    if (user == null) {
      state = AsyncValue.error(_noUserFailure, StackTrace.current);
      return TaskResult.left(Failure.presentation('No User Failure'));
    }
    state = AsyncData(user);
    return TaskResult<AuthUser>.right(user);
  }

  TaskResult<AuthUser> refresh() {
    return ref.read(authRepositoryProvider).refresh().chainFirst(setUser);
  }

  TaskResult<AuthUser> login(AuthUserType type, Map<String, dynamic> map) {
    final repo = ref.read(authRepositoryProvider);
    return repo.login(type, map).chainFirst(setUser);
  }

  TaskResult<void> logout() {
    return ref
        .read(authRepositoryProvider)
        .logout()
        .chainFirst((_) => setUser(null));
  }
}
