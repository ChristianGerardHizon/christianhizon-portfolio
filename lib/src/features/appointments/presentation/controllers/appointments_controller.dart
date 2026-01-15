import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/appointment_schedule_repository.dart';
import '../../domain/appointment_schedule.dart';

part 'appointments_controller.g.dart';

/// Controller for managing the main appointments list.
///
/// Provides a global, cached list of all appointments with CRUD operations.
@Riverpod(keepAlive: true)
class AppointmentsController extends _$AppointmentsController {
  @override
  Future<List<AppointmentSchedule>> build() async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).fetchAll();
    return result.fold(
      (failure) => throw failure,
      (appointments) => appointments,
    );
  }

  /// Refreshes the appointments list from the server.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(appointmentScheduleRepositoryProvider).fetchAll();
      return result.fold(
        (failure) => throw failure,
        (appointments) => appointments,
      );
    });
  }

  /// Creates a new appointment and adds it to the list.
  Future<bool> createAppointment(AppointmentSchedule appointment) async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).create(appointment);
    return result.fold(
      (failure) => false,
      (created) {
        state.whenData((appointments) {
          // Add to beginning of list (most recent first)
          state = AsyncValue.data([created, ...appointments]);
        });
        return true;
      },
    );
  }

  /// Creates a new appointment and returns it.
  ///
  /// Returns the created appointment on success, or null on failure.
  /// This is useful when the caller needs the created appointment's ID.
  Future<AppointmentSchedule?> createAppointmentAndReturn(AppointmentSchedule appointment) async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).create(appointment);
    return result.fold(
      (failure) => null,
      (created) {
        state.whenData((appointments) {
          // Add to beginning of list (most recent first)
          state = AsyncValue.data([created, ...appointments]);
        });
        return created;
      },
    );
  }

  /// Updates an existing appointment.
  Future<bool> updateAppointment(AppointmentSchedule appointment) async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).update(appointment);
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

  /// Updates an appointment's status.
  Future<bool> updateStatus(String id, AppointmentScheduleStatus status) async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).updateStatus(id, status);
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
    final result = await ref.read(appointmentScheduleRepositoryProvider).delete(id);
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

/// Provider for fetching a single appointment by ID.
@riverpod
Future<AppointmentSchedule?> appointment(Ref ref, String id) async {
  final result = await ref.read(appointmentScheduleRepositoryProvider).fetchOne(id);
  return result.fold(
    (failure) => null,
    (appointment) => appointment,
  );
}

/// Provider for fetching appointments by date.
@riverpod
Future<List<AppointmentSchedule>> appointmentsByDate(Ref ref, DateTime date) async {
  final result = await ref.read(appointmentScheduleRepositoryProvider).fetchByDate(date);
  return result.fold(
    (failure) => [],
    (appointments) => appointments,
  );
}
