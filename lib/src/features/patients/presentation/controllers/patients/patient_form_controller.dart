import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/patients/data/patient/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_form_controller.g.dart';
part 'patient_form_controller.mapper.dart';

@MappableClass()
class PatientFormState with PatientFormStateMappable {
  final Patient? patient;
  final List<Branch> branches;
  final List<PBImage>? images;

  PatientFormState({
    required this.patient,
    this.branches = const [],
    this.images,
  });
}

@riverpod
class PatientFormController extends _$PatientFormController {
  @override
  Future<PatientFormState> build(String? id) async {
    final patientRepo = ref.read(patientRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final branches = await $(_getBranches());

      if (id == null) {
        return PatientFormState(
          patient: null,
          branches: branches,
          images: null,
        );
      }

      final patient = await $(patientRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(patient, domain));

      return PatientFormState(
        patient: patient,
        branches: branches,
        images: images,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<List<Branch>> _getBranches() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(branchRepositoryProvider);
      final filter = '${BranchField.isDeleted} = false';
      final result = await repo.listAll(filter: filter).run();
      return result.fold(Future.error, Future.value);
    }, Failure.handle);
  }
}

TaskResult<List<PBImage>?> _buildInitialImages(
    Patient? patient, String domain) {
  return TaskResult.tryCatch(() async {
    if (patient == null) {
      return null;
    }

    final imageUri = PBUtils.imageBuilder(
      collection: patient.collectionId,
      domain: domain,
      fileName: patient.avatar!,
      id: patient.id,
    );

    if (imageUri == null) {
      return null;
    }

    return [
      PBNetworkImage(
        fileName: patient.avatar!,
        uri: imageUri,
        field: PatientField.avatar,
        id: patient.id,
      )
    ];
  }, Failure.handle);
}
