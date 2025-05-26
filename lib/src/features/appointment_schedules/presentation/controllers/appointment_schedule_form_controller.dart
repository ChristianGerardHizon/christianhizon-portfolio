import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/appointment_schedules/data/appointment_schedule_repository.dart';
import 'package:sannjosevet/src/features/appointment_schedules/domain/appointment_schedule.dart';
import 'package:sannjosevet/src/features/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:sannjosevet/src/features/patient_records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patient_records/presentation/controllers/patient_record_controller.dart';
import 'package:sannjosevet/src/features/patients/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appointment_schedule_form_controller.g.dart';

class AppointmentScheduleState {
  final AppointmentSchedule? appointmentSchedule;
  final Patient? patient;
  final PatientRecord? patientRecord;
  final List<Branch> branches;

  AppointmentScheduleState({
    this.appointmentSchedule,
    this.patient,
    this.patientRecord,
    this.branches = const [],
  });
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
      final branches = await ref.watch(branchesControllerProvider.future);

      ///
      /// New
      ///
      if (id == null) {
        return AppointmentScheduleState(
          branches: branches,
          appointmentSchedule: null,
          patient: patientId is String
              ? await ref.watch(patientControllerProvider(patientId).future)
              : null,
          patientRecord: patientRecordId is String
              ? await ref.watch(
                  patientRecordControllerProvider(patientRecordId).future)
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
        branches: branches,
        appointmentSchedule: appointmentSchedule,
        patient: patient is String
            ? await ref.watch(patientControllerProvider(patient).future)
            : null,
        patientRecord: patientRecord is String
            ? await ref
                .watch(patientRecordControllerProvider(patientRecord).future)
            : null,
      );
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
