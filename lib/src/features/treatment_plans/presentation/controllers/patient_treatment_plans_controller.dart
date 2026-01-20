import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/treatment_plan_repository.dart';
import '../../domain/treatment_plan.dart';
import '../../domain/treatment_plan_status.dart';

part 'patient_treatment_plans_controller.g.dart';

/// Controller for managing treatment plans for a specific patient.
///
/// This is a family provider - each patient has its own treatment plans state.
@riverpod
class PatientTreatmentPlansController
    extends _$PatientTreatmentPlansController {
  TreatmentPlanRepository get _repository =>
      ref.read(treatmentPlanRepositoryProvider);

  @override
  Future<List<TreatmentPlan>> build(String patientId) async {
    final result = await _repository.fetchByPatient(patientId);

    return result.fold(
      (failure) => throw failure,
      (plans) => plans,
    );
  }

  /// Refreshes the treatment plans list for this patient.
  Future<void> refresh() async {
    final patientId = this.patientId;
    state = const AsyncLoading();

    final result = await _repository.fetchByPatient(patientId);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (plans) => AsyncData(plans),
    );
  }

  /// Creates a new treatment plan with all its items.
  ///
  /// Returns the created plan on success, or null on failure.
  Future<TreatmentPlan?> createPlanWithItems(
    TreatmentPlan plan,
    List<DateTime> scheduledDates,
  ) async {
    final result = await _repository.createPlanWithItems(plan, scheduledDates);

    return result.fold(
      (failure) => null,
      (newPlan) {
        // Add to current list (newest first by startDate)
        final currentList = state.value ?? [];
        final updatedList = [newPlan, ...currentList];
        // Sort by startDate descending
        updatedList.sort((a, b) => b.startDate.compareTo(a.startDate));
        state = AsyncData(updatedList);
        return newPlan;
      },
    );
  }

  /// Updates the status of a treatment plan.
  Future<bool> updatePlanStatus(String id, TreatmentPlanStatus status) async {
    final result = await _repository.updateStatus(id, status);

    return result.fold(
      (failure) => false,
      (updatedPlan) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((p) {
          return p.id == updatedPlan.id ? updatedPlan : p;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Updates an existing treatment plan.
  Future<bool> updatePlan(TreatmentPlan plan) async {
    final result = await _repository.update(plan);

    return result.fold(
      (failure) => false,
      (updatedPlan) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((p) {
          return p.id == updatedPlan.id ? updatedPlan : p;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a treatment plan (soft delete).
  Future<bool> deletePlan(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        // Remove from current list
        final currentList = state.value ?? [];
        final updatedList = currentList.where((p) => p.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}

/// Provider for fetching only active treatment plans for a patient.
@riverpod
Future<List<TreatmentPlan>> activePatientTreatmentPlans(
  Ref ref,
  String patientId,
) async {
  final repository = ref.read(treatmentPlanRepositoryProvider);
  final result = await repository.fetchActiveByPatient(patientId);

  return result.fold(
    (failure) => throw failure,
    (plans) => plans,
  );
}
