import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:gym_system/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:gym_system/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_form_controller.g.dart';

class AppointmentScheduleState {
  final AppointmentSchedule? appointmentSchedule;
  final Patient? patient;
  final PatientRecord? patientRecord;

  AppointmentScheduleState(
      {this.appointmentSchedule, this.patient, this.patientRecord});
}

@riverpod
class AppointmentScheduleFormController
    extends _$AppointmentScheduleFormController {
  @override
  Future<AppointmentScheduleState> build(
    String? id, {
    String? patientId,
    String? patientRecordId,
  }) async {
    final repo = ref.read(appointmentScheduleRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      ///
      /// New
      ///
      if (id == null) {
        return AppointmentScheduleState(
          appointmentSchedule: null,
          patient: patientId is String
              ? await ref.watch(patientControllerProvider(patientId).future)
              : null,
          patientRecord: patientRecordId is String
              ? await ref.watch(patientRecordControllerProvider(patientRecordId).future)
              : null,
        );
      }

      ///
      /// Exisiting
      ///
      final appointmentSchedule = await $(repo.get(id));
      final patient = appointmentSchedule.patient;
      final patientRecord = appointmentSchedule.patientRecord;
      return AppointmentScheduleState(
        appointmentSchedule: appointmentSchedule,
        patient: patient is String
            ? await ref.watch(patientControllerProvider(patient).future)
            : null,
        patientRecord: patientRecord is String
            ? await ref.watch(patientRecordControllerProvider(patientRecord).future)
            : null,

      );
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
