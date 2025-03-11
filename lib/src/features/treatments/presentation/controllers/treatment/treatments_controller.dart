import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/treatments/data/treatment/treatment_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatments_controller.g.dart';

@riverpod
class TreatmentsController extends _$TreatmentsController {
  @override
  Future<PageResults<Treatment>> build() async {
    final repo = ref.read(historyTypeRepositoryProvider);
    final result = await repo
        .list(
          filter: 'isDeleted = false',
          pageNo: 1,
          pageSize: 50,
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
