import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/patient_treatment_repository.dart';
import '../../domain/patient_treatment.dart';

part 'patient_treatments_controller.g.dart';

/// Controller for managing the treatment catalog (list of all treatments).
///
/// This manages the list of treatment types available in the current branch.
@Riverpod(keepAlive: true)
class PatientTreatmentsController extends _$PatientTreatmentsController {
  PatientTreatmentRepository get _repository =>
      ref.read(patientTreatmentRepositoryProvider);

  /// Gets the current branch filter.
  String? get _branchFilter => ref.read(currentBranchFilterProvider);

  @override
  Future<List<PatientTreatment>> build() async {
    // Listen to branch changes and refresh
    ref.listen(currentBranchFilterProvider, (_, __) {
      refresh();
    });

    final result = await _repository.fetchAll(filter: _branchFilter);

    return result.fold(
      (failure) => throw failure,
      (treatments) => treatments,
    );
  }

  /// Refreshes the treatments list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll(filter: _branchFilter);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (treatments) => AsyncData(treatments),
    );
  }

  /// Creates a new treatment.
  Future<bool> createTreatment(PatientTreatment treatment) async {
    final result = await _repository.create(treatment);

    return result.fold(
      (failure) => false,
      (newTreatment) {
        final currentList = state.value ?? [];
        // Insert alphabetically by name
        final updatedList = [...currentList, newTreatment]
          ..sort((a, b) => a.name.compareTo(b.name));
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Updates an existing treatment.
  Future<bool> updateTreatment(PatientTreatment treatment) async {
    final result = await _repository.update(treatment);

    return result.fold(
      (failure) => false,
      (updatedTreatment) {
        final currentList = state.value ?? [];
        final updatedList = currentList.map((t) {
          return t.id == updatedTreatment.id ? updatedTreatment : t;
        }).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a treatment (soft delete).
  Future<bool> deleteTreatment(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        final currentList = state.value ?? [];
        final updatedList = currentList.where((t) => t.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}

/// Provider for a single treatment by ID.
@riverpod
Future<PatientTreatment?> patientTreatment(Ref ref, String id) async {
  final repository = ref.read(patientTreatmentRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (treatment) => treatment,
  );
}
