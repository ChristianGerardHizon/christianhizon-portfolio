import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/organization/admins/data/admin_repository.dart';
import 'package:sannjosevet/src/features/organization/admins/domain/admin.dart';
import 'package:sannjosevet/src/features/system/settings/domain/settings.dart';
import 'package:sannjosevet/src/features/system/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_update_controller.g.dart';

class AdminUpdateState {
  final Admin admin;
  final Settings settings;

  AdminUpdateState({required this.admin, required this.settings});
}

@riverpod
class AdminUpdateController extends _$AdminUpdateController {
  @override
  Future<AdminUpdateState> build(String id) async {
    final adminRepo = ref.read(adminRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);
    final result = await TaskResult.Do(($) async {
      final admin = await $(adminRepo.get(id));
      return AdminUpdateState(admin: admin, settings: settings);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
