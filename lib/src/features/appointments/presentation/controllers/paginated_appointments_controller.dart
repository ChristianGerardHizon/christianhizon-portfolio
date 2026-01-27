import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/foundation/paginated_state.dart';
import '../../data/repositories/appointment_schedule_repository.dart';
import '../../domain/appointment_schedule.dart';
import 'appointment_sort_controller.dart';

part 'paginated_appointments_controller.g.dart';

/// Controller for managing paginated appointments list.
@Riverpod(keepAlive: true)
class PaginatedAppointmentsController extends _$PaginatedAppointmentsController {
  AppointmentScheduleRepository get _repository =>
      ref.read(appointmentScheduleRepositoryProvider);

  /// Gets the current sort string from the sort controller.
  String get _currentSort =>
      ref.read(appointmentSortControllerProvider).toSortString();

  @override
  Future<PaginatedState<AppointmentSchedule>> build() async {
    // Listen to sort changes and refresh
    ref.listen(appointmentSortControllerProvider, (_, __) {
      refresh();
    });

    final result = await _repository.fetchPaginated(
      page: 1,
      perPage: Pagination.defaultPageSize,
      sort: _currentSort,
    );

    return result.fold(
      (failure) => throw failure,
      (paginated) => PaginatedState<AppointmentSchedule>(
        items: paginated.items,
        currentPage: paginated.page,
        totalItems: paginated.totalItems,
        totalPages: paginated.totalPages,
        hasReachedEnd: !paginated.hasMore,
      ),
    );
  }

  /// Loads the next page of appointments.
  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null ||
        currentState.isLoadingMore ||
        currentState.hasReachedEnd) {
      return;
    }

    // Set loading more state
    state = AsyncValue.data(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _repository.fetchPaginated(
      page: nextPage,
      perPage: Pagination.defaultPageSize,
      sort: _currentSort,
    );

    result.fold(
      (failure) {
        // Reset loading state on error
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

  /// Refreshes the list from the beginning (respects current sort).
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await _repository.fetchPaginated(
        page: 1,
        perPage: Pagination.defaultPageSize,
        sort: _currentSort,
      );
      return result.fold(
        (failure) => throw failure,
        (paginated) => PaginatedState<AppointmentSchedule>(
          items: paginated.items,
          currentPage: paginated.page,
          totalItems: paginated.totalItems,
          totalPages: paginated.totalPages,
          hasReachedEnd: !paginated.hasMore,
        ),
      );
    });
  }

  /// Creates a new appointment and adds it to the top of the list.
  Future<bool> createAppointment(AppointmentSchedule appointment) async {
    final result = await _repository.create(appointment);
    return result.fold(
      (failure) => false,
      (created) {
        state.whenData((currentState) {
          state = AsyncValue.data(currentState.prependItem(created));
        });
        return true;
      },
    );
  }

  /// Creates appointment and returns it.
  Future<AppointmentSchedule?> createAppointmentAndReturn(
    AppointmentSchedule appointment,
  ) async {
    final result = await _repository.create(appointment);
    return result.fold(
      (failure) => null,
      (created) {
        state.whenData((currentState) {
          state = AsyncValue.data(currentState.prependItem(created));
        });
        return created;
      },
    );
  }

  /// Updates an existing appointment.
  Future<bool> updateAppointment(AppointmentSchedule appointment) async {
    final result = await _repository.update(appointment);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((currentState) {
          state = AsyncValue.data(
            currentState.updateItem(updated, (a) => a.id == updated.id),
          );
        });
        return true;
      },
    );
  }

  /// Updates an appointment's status.
  Future<bool> updateStatus(String id, AppointmentScheduleStatus status) async {
    final result = await _repository.updateStatus(id, status);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((currentState) {
          state = AsyncValue.data(
            currentState.updateItem(updated, (a) => a.id == updated.id),
          );
        });
        return true;
      },
    );
  }

  /// Deletes an appointment.
  Future<bool> deleteAppointment(String id) async {
    final result = await _repository.delete(id);
    return result.fold(
      (failure) => false,
      (_) {
        state.whenData((currentState) {
          state = AsyncValue.data(
            currentState.removeItem((a) => a.id == id),
          );
        });
        return true;
      },
    );
  }
}
