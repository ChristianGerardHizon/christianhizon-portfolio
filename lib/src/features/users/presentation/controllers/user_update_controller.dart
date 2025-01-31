import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_update_controller.g.dart';

class UserUpdateState {
  final User user;
  final Settings settings;

  UserUpdateState({required this.user, required this.settings});
}

@riverpod
class UserUpdateController extends _$UserUpdateController {
  @override
  Future<UserUpdateState> build(String id) async {
    final userRepo = ref.read(userRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);
    final result = await TaskResult.Do(($) async {
      final user = await $(userRepo.get(id));
      return UserUpdateState(user: user, settings: settings);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
