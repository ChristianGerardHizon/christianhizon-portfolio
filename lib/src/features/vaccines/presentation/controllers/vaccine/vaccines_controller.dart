import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/features/vaccines/data/vaccine/vaccine_repository.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vaccines_controller.g.dart';

@riverpod
class VaccinesController extends _$VaccinesController {
  @override
  Future<PageResults<Vaccine>> build() async {
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
