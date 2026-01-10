import 'package:sannjosevet/src/features/organization/admins/data/admin_repository.dart';
import 'package:sannjosevet/src/features/organization/admins/domain/admin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_controller.g.dart';

@riverpod
class AdminController extends _$AdminController {
  @override
  Future<Admin> build(String id) async {
    final repo = ref.read(adminRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
