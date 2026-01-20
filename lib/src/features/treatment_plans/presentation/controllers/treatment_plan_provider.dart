import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/treatment_plan_repository.dart';
import '../../domain/treatment_plan.dart';

part 'treatment_plan_provider.g.dart';

/// Provider for fetching a single treatment plan by ID.
@riverpod
Future<TreatmentPlan?> treatmentPlan(
  Ref ref,
  String id,
) async {
  final repository = ref.read(treatmentPlanRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (plan) => plan,
  );
}
