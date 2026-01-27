import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../settings/presentation/controllers/current_branch_controller.dart';
import '../../data/repositories/appointment_schedule_repository.dart';
import '../../domain/appointment_schedule.dart';

part 'daily_appointments_controller.g.dart';

/// Controller for managing appointments for a specific date.
///
/// Fetches only appointments for the selected date and current branch,
/// making it more efficient than loading all appointments.
@riverpod
class DailyAppointmentsController extends _$DailyAppointmentsController {
  /// Gets the current branch filter.
  String? get _branchFilter => ref.read(currentBranchFilterProvider);

  @override
  Future<List<AppointmentSchedule>> build(DateTime date) async {
    // Listen to branch changes and refresh
    ref.listen(currentBranchFilterProvider, (_, __) {
      refresh();
    });

    final result = await ref
        .read(appointmentScheduleRepositoryProvider)
        .fetchByDate(date, filter: _branchFilter);
    return result.fold(
      (failure) => throw failure,
      (appointments) => appointments,
    );
  }

  /// Refreshes the appointments list for the current date.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(appointmentScheduleRepositoryProvider)
          .fetchByDate(date, filter: _branchFilter);
      return result.fold(
        (failure) => throw failure,
        (appointments) => appointments,
      );
    });
  }

  /// Checks if the given date is on the controller's date.
  bool _isOnDate(DateTime appointmentDate) {
    return appointmentDate.year == date.year &&
        appointmentDate.month == date.month &&
        appointmentDate.day == date.day;
  }

  /// Creates a new appointment and adds it to the list if on this date.
  Future<bool> createAppointment(AppointmentSchedule appointment) async {
    final result =
        await ref.read(appointmentScheduleRepositoryProvider).create(appointment);
    return result.fold(
      (failure) => false,
      (created) {
        if (_isOnDate(created.date)) {
          state.whenData((appointments) {
            state = AsyncValue.data([created, ...appointments]);
          });
        }
        return true;
      },
    );
  }

  /// Creates a new appointment and returns it.
  Future<AppointmentSchedule?> createAppointmentAndReturn(
      AppointmentSchedule appointment) async {
    final result =
        await ref.read(appointmentScheduleRepositoryProvider).create(appointment);
    return result.fold(
      (failure) => null,
      (created) {
        if (_isOnDate(created.date)) {
          state.whenData((appointments) {
            state = AsyncValue.data([created, ...appointments]);
          });
        }
        return created;
      },
    );
  }

  /// Updates an existing appointment.
  Future<bool> updateAppointment(AppointmentSchedule appointment) async {
    final result =
        await ref.read(appointmentScheduleRepositoryProvider).update(appointment);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((appointments) {
          final index = appointments.indexWhere((a) => a.id == updated.id);
          final isOnDate = _isOnDate(updated.date);

          if (index != -1) {
            if (isOnDate) {
              final newList = [...appointments];
              newList[index] = updated;
              state = AsyncValue.data(newList);
            } else {
              // Remove from list (date changed to different day)
              state = AsyncValue.data(
                appointments.where((a) => a.id != updated.id).toList(),
              );
            }
          } else if (isOnDate) {
            // Add to list (date changed to this day)
            state = AsyncValue.data([updated, ...appointments]);
          }
        });
        return true;
      },
    );
  }

  /// Updates an appointment's status.
  Future<bool> updateStatus(String id, AppointmentScheduleStatus status) async {
    final result = await ref
        .read(appointmentScheduleRepositoryProvider)
        .updateStatus(id, status);
    return result.fold(
      (failure) => false,
      (updated) {
        state.whenData((appointments) {
          final index = appointments.indexWhere((a) => a.id == updated.id);
          if (index != -1) {
            final newList = [...appointments];
            newList[index] = updated;
            state = AsyncValue.data(newList);
          }
        });
        return true;
      },
    );
  }

  /// Deletes an appointment (soft delete).
  Future<bool> deleteAppointment(String id) async {
    final result =
        await ref.read(appointmentScheduleRepositoryProvider).delete(id);
    return result.fold(
      (failure) => false,
      (_) {
        state.whenData((appointments) {
          state = AsyncValue.data(
            appointments.where((a) => a.id != id).toList(),
          );
        });
        return true;
      },
    );
  }
}
