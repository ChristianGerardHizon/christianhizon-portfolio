import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/domain/auth_admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_data.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

class DashboardState {
  final AuthData auth;

  DashboardState({required this.auth});
}

@riverpod
class DashboardController extends _$DashboardController {
  @override
  FutureOr<DashboardState> build() async {
    final result = await TaskResult.Do(($) async {
      ///
      /// Get Auth
      ///
      final auth = await $(_getAuth());
      return DashboardState(auth: auth);
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<AuthData> _getAuth() {
    return TaskResult.tryCatch(
      () async {
        return await ref.watch(authControllerProvider.future);
      },
      Failure.tryCatchPresentation,
    );
  }
}
