import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/features/system_versions/data/system_version_repository.dart';
import 'package:gym_system/src/features/system_versions/domain/system_version.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_system_version_controller.g.dart';

@riverpod
class LatestSystemVersionController extends _$LatestSystemVersionController {
  @override
  FutureOr<SystemVersion> build() async {
    final repo = ref.read(systemVersionRepositoryProvider);

    final result = await repo
        .listAll(batch: 1, sort: '-${SystemVersionField.created}')
        .run();

    return result.fold(Future.error, (x) => Future.value(x.first));
  }
}
