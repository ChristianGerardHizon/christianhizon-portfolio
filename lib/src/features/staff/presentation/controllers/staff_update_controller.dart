import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/staff/data/staff_repository.dart';
import 'package:gym_system/src/features/staff/domain/staff.dart';
import 'package:gym_system/src/features/settings/domain/settings.dart';
import 'package:gym_system/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_update_controller.g.dart';

class StaffUpdateState {
  final Staff staff;
  final Settings settings;

  StaffUpdateState({required this.staff, required this.settings});
}

@riverpod
class StaffUpdateController extends _$StaffUpdateController {
  @override
  Future<StaffUpdateState> build(String id) async {
    final staffRepo = ref.read(staffRepositoryProvider);
    final settings = await ref.read(settingsControllerProvider.future);
    final result = await TaskResult.Do(($) async {
      final staff = await $(staffRepo.get(id));
      return StaffUpdateState(staff: staff, settings: settings);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
