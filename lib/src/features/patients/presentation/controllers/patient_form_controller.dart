import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:gym_system/src/features/patient_species/presentation/controllers/patient_species_controller.dart';
import 'package:gym_system/src/features/patients/data/patient_repository.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:gym_system/src/features/patient_breeds/domain/patient_breed.dart';
import 'package:gym_system/src/features/patient_species/domain/patient_species.dart';
import 'package:gym_system/src/features/patient_breeds/presentation/controllers/patient_breeds_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_form_controller.g.dart';
part 'patient_form_controller.mapper.dart';

@MappableClass()
class PatientFormState with PatientFormStateMappable {
  final Patient? patient;
  final List<Branch> branches;
  final List<PBImage>? images;

  final List<PatientSpecies> species;
  final List<PatientBreed> breeds;
  final List<PatientSex> sexes;

  PatientFormState({
    required this.patient,
    this.branches = const [],
    this.images,
    this.species = const [],
    this.breeds = const [],
    this.sexes = const [],
  });
}

@riverpod
class PatientFormController extends _$PatientFormController {
  @override
  Future<PatientFormState> build(String? id) async {
    final patientRepo = ref.read(patientRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final branches = await ref.read(branchesControllerProvider.future);
      final species = await ref.read(patientSpeciesControllerProvider.future);
      final breeds = await ref.read(patientBreedsControllerProvider.future);
      final sexes = PatientSex.values;

      if (id == null) {
        return PatientFormState(
          patient: null,
          images: null,
          branches: branches,
          species: species,
          breeds: breeds,
          sexes: sexes,
        );
      }

      final patient = await $(patientRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(patient, domain));

      return PatientFormState(
        patient: patient,
        branches: branches,
        images: images,
        species: species,
        breeds: breeds,
        sexes: sexes,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}

TaskResult<List<PBImage>?> _buildInitialImages(
    Patient? patient, String domain) {
  return TaskResult.tryCatch(() async {
    if (patient == null) {
      return null;
    }

    if (patient.avatar == null || patient.avatar!.isEmpty) {
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
