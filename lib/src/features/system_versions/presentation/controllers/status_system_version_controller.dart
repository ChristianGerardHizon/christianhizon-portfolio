import 'package:gym_system/src/core/controllers/package_info_controller.dart';
import 'package:gym_system/src/features/system_versions/presentation/controllers/latest_system_version_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'status_system_version_controller.g.dart';

class StatusSystemVersionState {
  final String version;
  final String build;
  final bool hasUpdate;
  final String mobileUrl;

  StatusSystemVersionState({
    required this.version,
    required this.build,
    required this.hasUpdate,
    required this.mobileUrl,
  });
}

@riverpod
class StatusSystemVersionController extends _$StatusSystemVersionController {
  @override
  FutureOr<StatusSystemVersionState> build() async {
    final package = await ref.watch(packageInfoControllerProvider.future);
    final latestBuild =
        await ref.watch(latestSystemVersionControllerProvider.future);
    return StatusSystemVersionState(
      version: package.version,
      build: package.buildNumber,
      hasUpdate: latestBuild.buildNumber != num.tryParse(package.buildNumber),
      mobileUrl: latestBuild.mobileUrl,
    );
  }
}
