import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/authentication/domain/auth_data.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:gym_system/src/features/patient_records/data/patient_record_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';
import 'package:gym_system/src/features/patients/presentation/controllers/patient_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_form_controller.g.dart';
part 'patient_record_form_controller.mapper.dart';

@MappableClass()
class PatientRecordFormState with PatientRecordFormStateMappable {
  final PatientRecord? patientRecord;
  final Patient patient;
  final List<Branch> branches;
  final AuthData auth;
  PatientRecordFormState({
    required this.patientRecord,
    required this.patient,
    this.branches = const [],
    required this.auth,
  });
}

@riverpod
class PatientRecordFormController extends _$PatientRecordFormController {
  @override
  Future<PatientRecordFormState> build({
    String? id,
    required String patientId,
  }) async {
    final auth = await ref.read(authControllerProvider.future);
    final patientRecordRepo = ref.read(patientRecordRepositoryProvider);
    final patient = await ref.read(patientControllerProvider(patientId).future);
    final branches = await ref.read(branchesControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return PatientRecordFormState(
          patientRecord: null,
          patient: patient,
          auth: auth,
          branches: branches,
        );
      }

      final patientRecord = await $(patientRecordRepo.get(id));

      return PatientRecordFormState(
        patientRecord: patientRecord,
        patient: patient,
        auth: auth,
        branches: branches,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
