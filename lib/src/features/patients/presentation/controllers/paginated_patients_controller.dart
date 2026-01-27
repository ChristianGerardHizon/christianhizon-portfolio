import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/foundation/paginated_state.dart';
import '../../data/repositories/patient_repository.dart';
import '../../domain/patient.dart';
import 'patient_sort_controller.dart';

part 'paginated_patients_controller.g.dart';

/// Controller for managing paginated patients list.
@Riverpod(keepAlive: true)
class PaginatedPatientsController extends _$PaginatedPatientsController {
  PatientRepository get _repository => ref.read(patientRepositoryProvider);

  // Track current search state
  String? _currentSearchQuery;
  List<String>? _currentSearchFields;

  /// Gets the current sort string from the sort controller.
  String get _currentSort =>
      ref.read(patientSortControllerProvider).toSortString();

  @override
  Future<PaginatedState<Patient>> build() async {
    _currentSearchQuery = null;
    _currentSearchFields = null;

    // Listen to sort changes and refresh
    ref.listen(patientSortControllerProvider, (_, __) {
      refresh();
    });

    final result = await _repository.fetchPaginated(
      page: 1,
      perPage: Pagination.defaultPageSize,
      sort: _currentSort,
    );

    return result.fold(
      (failure) => throw failure,
      (paginated) => PaginatedState<Patient>(
        items: paginated.items,
        currentPage: paginated.page,
        totalItems: paginated.totalItems,
        totalPages: paginated.totalPages,
        hasReachedEnd: !paginated.hasMore,
      ),
    );
  }

  /// Whether search is currently active.
  bool get isSearchActive => _currentSearchQuery != null;

  /// The current search query, if any.
  String? get currentSearchQuery => _currentSearchQuery;

  /// Loads the next page.
  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null ||
        currentState.isLoadingMore ||
        currentState.hasReachedEnd) {
      return;
    }

    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;

    // Use search or regular fetch based on current state
    final result = _currentSearchQuery != null
        ? await _repository.searchPaginated(
            _currentSearchQuery!,
            fields: _currentSearchFields,
            page: nextPage,
            perPage: Pagination.defaultPageSize,
            sort: _currentSort,
          )
        : await _repository.fetchPaginated(
            page: nextPage,
            perPage: Pagination.defaultPageSize,
            sort: _currentSort,
          );

    result.fold(
      (failure) {
        state = AsyncValue.data(currentState.copyWith(isLoadingMore: false));
      },
      (paginated) {
        state = AsyncValue.data(
          currentState.appendItems(
            paginated.items,
            page: paginated.page,
            totalItems: paginated.totalItems,
            totalPages: paginated.totalPages,
          ),
        );
      },
    );
  }

  /// Refreshes the list (respects current search and sort).
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    final result = _currentSearchQuery != null
        ? await _repository.searchPaginated(
            _currentSearchQuery!,
            fields: _currentSearchFields,
            page: 1,
            perPage: Pagination.defaultPageSize,
            sort: _currentSort,
          )
        : await _repository.fetchPaginated(
            page: 1,
            perPage: Pagination.defaultPageSize,
            sort: _currentSort,
          );

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (paginated) => AsyncData(PaginatedState<Patient>(
        items: paginated.items,
        currentPage: paginated.page,
        totalItems: paginated.totalItems,
        totalPages: paginated.totalPages,
        hasReachedEnd: !paginated.hasMore,
      )),
    );
  }

  /// Searches patients (resets to page 1).
  Future<void> search(String query, {List<String>? fields}) async {
    if (query.isEmpty) {
      return clearSearch();
    }

    _currentSearchQuery = query;
    _currentSearchFields = fields;

    state = const AsyncValue.loading();

    final result = await _repository.searchPaginated(
      query,
      fields: fields,
      page: 1,
      perPage: Pagination.defaultPageSize,
      sort: _currentSort,
    );

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (paginated) => AsyncData(PaginatedState<Patient>(
        items: paginated.items,
        currentPage: paginated.page,
        totalItems: paginated.totalItems,
        totalPages: paginated.totalPages,
        hasReachedEnd: !paginated.hasMore,
      )),
    );
  }

  /// Clears search and reloads all patients.
  Future<void> clearSearch() async {
    _currentSearchQuery = null;
    _currentSearchFields = null;
    return refresh();
  }

  /// Creates a new patient.
  Future<bool> createPatient(Patient patient) async {
    final result = await _repository.create(patient);
    return result.fold(
      (failure) => false,
      (newPatient) {
        state.whenData((currentState) {
          state = AsyncValue.data(currentState.prependItem(newPatient));
        });
        return true;
      },
    );
  }

  /// Updates an existing patient.
  Future<bool> updatePatient(Patient patient) async {
    final result = await _repository.update(patient);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((currentState) {
          state = AsyncValue.data(
            currentState.updateItem(updated, (p) => p.id == updated.id),
          );
        });
        return true;
      },
    );
  }

  /// Deletes a patient.
  Future<bool> deletePatient(String id) async {
    final result = await _repository.delete(id);
    return result.fold(
      (failure) => false,
      (_) {
        state.whenData((currentState) {
          state = AsyncValue.data(
            currentState.removeItem((p) => p.id == id),
          );
        });
        return true;
      },
    );
  }
}
