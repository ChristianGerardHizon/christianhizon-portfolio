import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/treatment_plan_item_repository.dart';
import '../../domain/treatment_plan_item.dart';
import '../../domain/treatment_plan_item_status.dart';

part 'treatment_plan_items_controller.g.dart';

/// Controller for managing treatment plan items for a specific plan.
///
/// This is a family provider - each plan has its own items state.
@riverpod
class TreatmentPlanItemsController extends _$TreatmentPlanItemsController {
  TreatmentPlanItemRepository get _repository =>
      ref.read(treatmentPlanItemRepositoryProvider);

  bool _isDisposed = false;

  @override
  Future<List<TreatmentPlanItem>> build(String planId) async {
    ref.onDispose(() => _isDisposed = true);

    final result = await _repository.fetchByPlan(planId);

    return result.fold(
      (failure) => throw failure,
      (items) => items,
    );
  }

  /// Refreshes the items list for this plan.
  Future<void> refresh() async {
    final planId = this.planId;
    state = const AsyncLoading();

    final result = await _repository.fetchByPlan(planId);

    // Check if provider is still mounted before updating state
    if (_isDisposed) return;

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (items) => AsyncData(items),
    );
  }

  /// Marks an item as completed.
  Future<bool> markCompleted(String itemId) async {
    final result = await _repository.updateStatus(
      itemId,
      TreatmentPlanItemStatus.completed,
      completedDate: DateTime.now(),
    );

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Marks an item as skipped.
  Future<bool> markSkipped(String itemId) async {
    final result = await _repository.updateStatus(
      itemId,
      TreatmentPlanItemStatus.skipped,
    );

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Marks an item as missed.
  Future<bool> markMissed(String itemId) async {
    final result = await _repository.updateStatus(
      itemId,
      TreatmentPlanItemStatus.missed,
    );

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Reschedules an item to a new date.
  Future<bool> reschedule(String itemId, DateTime newDate) async {
    final result = await _repository.reschedule(itemId, newDate);

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Links an appointment to this item.
  Future<bool> linkAppointment(String itemId, String appointmentId) async {
    final result = await _repository.linkAppointment(itemId, appointmentId);

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Unlinks an appointment from this item.
  Future<bool> unlinkAppointment(String itemId) async {
    final result = await _repository.unlinkAppointment(itemId);

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updatedItem) {
        _updateItemInState(updatedItem);
        return true;
      },
    );
  }

  /// Updates an item's notes.
  Future<bool> updateNotes(String itemId, String? notes) async {
    final currentItems = state.value ?? [];
    final item = currentItems.firstWhere(
      (i) => i.id == itemId,
      orElse: () => throw Exception('Item not found'),
    );

    final updatedItem = item.copyWith(notes: notes);
    final result = await _repository.update(updatedItem);

    if (_isDisposed) return false;

    return result.fold(
      (failure) => false,
      (updated) {
        _updateItemInState(updated);
        return true;
      },
    );
  }

  /// Helper to update an item in the current state.
  void _updateItemInState(TreatmentPlanItem updatedItem) {
    final currentList = state.value ?? [];
    final updatedList = currentList.map((item) {
      return item.id == updatedItem.id ? updatedItem : item;
    }).toList();
    state = AsyncData(updatedList);
  }
}

/// Provider for a single treatment plan item by ID.
@riverpod
Future<TreatmentPlanItem?> treatmentPlanItem(
  Ref ref,
  String id,
) async {
  final repository = ref.read(treatmentPlanItemRepositoryProvider);
  final result = await repository.fetchOne(id);

  return result.fold(
    (failure) => null,
    (item) => item,
  );
}

/// Provider for upcoming treatment plan items across all plans.
@riverpod
Future<List<TreatmentPlanItem>> upcomingTreatmentPlanItems(
  Ref ref,
  int daysAhead,
) async {
  final repository = ref.read(treatmentPlanItemRepositoryProvider);
  final result = await repository.fetchUpcoming(daysAhead);

  return result.fold(
    (failure) => throw failure,
    (items) => items,
  );
}
