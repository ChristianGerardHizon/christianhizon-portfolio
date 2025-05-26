import 'package:sannjosevet/src/features/settings/data/setting_repository.dart';
import 'package:sannjosevet/src/features/settings/domain/settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {
  @override
  FutureOr<Settings> build() async {
    final repo = ref.read(settingRepositoryProvider);
    final result = await repo.get().run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
