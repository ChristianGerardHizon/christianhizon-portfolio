import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/system/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/controllers/auth_controller.dart';
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
      Failure.handle,
    );
  }
}
