import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/appointment_schedule_repository.dart';
import '../../domain/appointment_schedule.dart';

part 'patient_appointments_controller.g.dart';

/// Controller for managing appointments for a specific patient.
///
/// Uses a family provider pattern to maintain separate state per patient.
@riverpod
class PatientAppointmentsController extends _$PatientAppointmentsController {
  @override
  Future<List<AppointmentSchedule>> build(String patientId) async {
    final result = await ref.read(appointmentScheduleRepositoryProvider).fetchByPatient(patientId);
    return result.fold(
      (failure) => throw failure,
      (appointments) => appointments,
    );
  }

  /// Refreshes the appointments list for this patient.
  Future<void> refresh() async {
    final patientId = this.patientId;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(appointmentScheduleRepositoryProvider).fetchByPatient(patientId);
      return result.fold(
        (failure) => throw failure,
        (appointments) => appointments,
      );
    });
  }

  /// Creates a new appointment for this patient.
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

  /// Creates a new appointment for this patient and returns it.
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
