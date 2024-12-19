import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/data/auth_repository.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  ///
  /// default no user failure
  ///
  final _noUserFailure = Failure.presentation('User not found');

  @override
  Future<User> build() async {
    final result = await ref
        .read(authRepositoryProvider)
        .getSavedUser()
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

  TaskResult<User> setUser(User? user) {
    if (user == null) {
      state = AsyncValue.error(_noUserFailure, StackTrace.current);
      return TaskResult.left(Failure.presentation('No User Failure'));
    }

    state = AsyncData(user);
    return TaskResult<User>.right(user);
  }

  TaskResult<User> refresh() {
    return ref.read(authRepositoryProvider).refresh().chainFirst(setUser);
  }

  TaskResult<User> login(Map<String, dynamic> map) {
    final repo = ref.read(authRepositoryProvider);
    return repo.login(map).chainFirst(setUser);
  }

  TaskResult<User> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
  }) {
    final repo = ref.read(authRepositoryProvider);

    return repo
        .register(
          email: email,
          name: name,
          password: password,
          passwordConfirm: passwordConfirm,
        )
        .chainFirst(setUser);
  }

  TaskResult<void> logout() {
    return ref
        .read(authRepositoryProvider)
        .logout()
        .chainFirst((_) => setUser(null));
  }
}
