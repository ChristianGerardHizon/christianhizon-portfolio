import 'package:sannjosevet/src/core/controllers/package_info_controller.dart';
import 'package:sannjosevet/src/features/system/system_versions/domain/system_artifact.dart';
import 'package:sannjosevet/src/features/system/system_versions/presentation/controllers/latest_system_version_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'status_system_version_controller.g.dart';

class StatusSystemVersionState {
  final String version;
  final String build;
  final bool hasUpdate;
  final List<SystemArtifact> artifacts;

  StatusSystemVersionState({
    required this.version,
    required this.build,
    required this.hasUpdate,
    this.artifacts = const [],
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
      hasUpdate: latestBuild == null
          ? false
          : latestBuild.buildNumber != num.tryParse(package.buildNumber),
      artifacts: latestBuild?.artifacts ?? [],
    );
  }
}
