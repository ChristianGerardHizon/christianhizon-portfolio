import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/treatment_template_repository.dart';
import '../../domain/treatment_template.dart';

part 'treatment_templates_controller.g.dart';

/// Controller for managing treatment templates.
@riverpod
class TreatmentTemplatesController extends _$TreatmentTemplatesController {
  TreatmentTemplateRepository get _repository =>
      ref.read(treatmentTemplateRepositoryProvider);

  @override
  Future<List<TreatmentTemplate>> build() async {
    final result = await _repository.fetchAll();

    return result.fold(
      (failure) => throw failure,
      (templates) => templates,
    );
  }

  /// Refreshes the templates list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll();

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (templates) => AsyncData(templates),
    );
  }

  /// Creates a new treatment template.
  Future<TreatmentTemplate?> createTemplate(TreatmentTemplate template) async {
    final result = await _repository.create(template);

    return result.fold(
      (failure) => null,
      (newTemplate) {
        // Add to current list
        final currentList = state.value ?? [];
        state = AsyncData([...currentList, newTemplate]);
        return newTemplate;
      },
    );
  }

  /// Updates an existing treatment template.
  Future<bool> updateTemplate(TreatmentTemplate template) async {
    final result = await _repository.update(template);

    return result.fold(
      (failure) => false,
      (updatedTemplate) {
        // Update in current list
        final currentList = state.value ?? [];
        final updatedList = currentList.map((t) {
          return t.id == updatedTemplate.id ? updatedTemplate : t;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a treatment template (soft delete).
  Future<bool> deleteTemplate(String id) async {
    final result = await _repository.delete(id);

    return result.fold(
      (failure) => false,
      (_) {
        // Remove from current list
        final currentList = state.value ?? [];
        final updatedList = currentList.where((t) => t.id != id).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }
}

/// Provider for a single treatment template by ID.
@riverpod
Future<TreatmentTemplate?> treatmentTemplate(
  Ref ref,
  String id,
) async {
  final repository = ref.read(treatmentTemplateRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (template) => template,
  );
}

/// Provider for templates filtered by treatment ID.
@riverpod
Future<List<TreatmentTemplate>> templatesByTreatment(
  Ref ref,
  String treatmentId,
) async {
  final repository = ref.read(treatmentTemplateRepositoryProvider);
  final result = await repository.fetchByTreatment(treatmentId);

  return result.fold(
    (failure) => throw failure,
    (templates) => templates,
  );
}
