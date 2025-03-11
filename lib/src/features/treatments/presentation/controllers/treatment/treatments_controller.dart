import 'package:gym_system/src/features/treatments/data/treatment/treatment_repository.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatments_controller.g.dart';

@riverpod
class TreatmentsController extends _$TreatmentsController {
  @override
  FutureOr<List<Treatment>> build() async {
    final result = await ref.read(treatmentRepositoryProvider).listAll().run();
    return result.fold(Future.error, Future.value);
  }
}
