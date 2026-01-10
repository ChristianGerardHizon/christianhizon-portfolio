import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/system/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/system/authentication/presentation/controllers/auth_controller.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/organization/branches/presentation/controllers/branches_controller.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/data/patient_treatment_record_repository.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/domain/patient_treatment_record.dart';
import 'package:sannjosevet/src/features/patients/treatments/domain/patient_treatment.dart';
import 'package:sannjosevet/src/features/patients/treatments/presentation/controllers/patient_treatments_controller.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:sannjosevet/src/features/patients/core/presentation/controllers/patient_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_form_controller.g.dart';
part 'patient_treatment_record_form_controller.mapper.dart';

@MappableClass()
class PatientTreatmentRecordFormState
    with PatientTreatmentRecordFormStateMappable {
  final PatientTreatmentRecord? patientTreatmentRecord;
  final Patient patient;
  final List<Branch> branches;
  final List<PatientTreatment> patientTreatments;
  final AuthData auth;
  PatientTreatmentRecordFormState({
    required this.patientTreatmentRecord,
    required this.patient,
    this.branches = const [],
    this.patientTreatments = const [],
    required this.auth,
  });
}

@riverpod
class PatientTreatmentRecordFormController
    extends _$PatientTreatmentRecordFormController {
  @override
  Future<PatientTreatmentRecordFormState> build(
      {String? id, required String patientId}) async {
    final auth = await ref.read(authControllerProvider.future);
    final patientTreatmentRecordRepo =
        ref.read(patientTreatmentRecordRepositoryProvider);
    final patient = await ref.read(patientControllerProvider(patientId).future);
    final branches = await ref.read(branchesControllerProvider.future);
    final patientTreatments =
        await ref.read(patientTreatmentsControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientTreatmentRecordFormState(
          patientTreatmentRecord: null,
          patient: patient,
          auth: auth,
          branches: branches,
          patientTreatments: patientTreatments,
        );
      }

      final patientTreatmentRecord =
          await $(patientTreatmentRecordRepo.get(id));

      return PatientTreatmentRecordFormState(
        patientTreatmentRecord: patientTreatmentRecord,
        patient: patient,
        auth: auth,
        branches: branches,
        patientTreatments: patientTreatments,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
