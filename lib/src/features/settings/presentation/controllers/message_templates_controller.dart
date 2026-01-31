import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/message_template_repository.dart';
import '../../domain/message_template.dart';

part 'message_templates_controller.g.dart';

/// Controller for managing message template list state.
///
/// Provides methods for fetching and CRUD operations on message templates.
@Riverpod(keepAlive: true)
class MessageTemplatesController extends _$MessageTemplatesController {
  MessageTemplateRepository get _repository =>
      ref.read(messageTemplateRepositoryProvider);

  /// Gets the current branch filter.
  String? get _branchFilter => ref.read(currentBranchFilterProvider);

  @override
  Future<List<MessageTemplate>> build() async {
    // Watch branch filter — triggers rebuild when branch changes.
    final branchFilter = ref.watch(currentBranchFilterProvider);

    final result = await _repository.fetchAll(filter: branchFilter);
    return result.fold(
      (failure) => throw failure,
      (templates) => templates,
    );
  }

  /// Refreshes the template list.
  Future<void> refresh() async {
    state = const AsyncLoading();

    final result = await _repository.fetchAll(filter: _branchFilter);

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (templates) => AsyncData(templates),
    );
  }

  /// Creates a new message template.
  Future<bool> createTemplate(MessageTemplate template) async {
    final result = await _repository.create(template);

    return result.fold(
      (failure) => false,
      (newTemplate) {
        final currentList = state.value ?? [];
        state = AsyncData([newTemplate, ...currentList]);
        return true;
      },
    );
  }

  /// Updates an existing message template.
  Future<bool> updateTemplate(MessageTemplate template) async {
    final result = await _repository.update(template);

    return result.fold(
      (failure) => false,
      (updatedTemplate) {
        final currentList = state.value ?? [];
        final updatedList = currentList.map((t) {
          return t.id == updatedTemplate.id ? updatedTemplate : t;
        }).toList();
        state = AsyncData(updatedList);
        return true;
      },
    );
  }

  /// Deletes a message template (soft delete).
  Future<bool> deleteTemplate(String id) async {
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

  /// Returns templates grouped by category.
  Map<String, List<MessageTemplate>> get groupedByCategory {
    final templates = state.value ?? [];
    final grouped = <String, List<MessageTemplate>>{};

    for (final template in templates) {
      final category = template.category ?? 'Uncategorized';
      grouped.putIfAbsent(category, () => []).add(template);
    }

    return grouped;
  }

  /// Returns a list of unique categories.
  List<String> get categories {
    final templates = state.value ?? [];
    final categorySet = <String>{};

    for (final template in templates) {
      categorySet.add(template.category ?? 'Uncategorized');
    }

    return categorySet.toList()..sort();
  }

  /// Returns the first template for a given category.
  MessageTemplate? getFirstForCategory(String category) {
    final templates = state.value ?? [];
    return templates.firstWhereOrNull(
      (t) => t.category == category,
    );
  }
}
