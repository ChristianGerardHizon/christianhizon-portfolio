import 'package:sannjosevet/src/features/users/data/user_repository.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  Future<User> build(String id) async {
    final repo = ref.read(userRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
