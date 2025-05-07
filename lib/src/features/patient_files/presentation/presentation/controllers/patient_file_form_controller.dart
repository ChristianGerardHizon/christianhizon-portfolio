import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/pb_image.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/patient_files/domain/patient_file.dart';
import 'package:gym_system/src/features/patient_files/presentation/presentation/controllers/patient_file_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_file_form_controller.g.dart';

class PatientFileFormState {
  final PatientFile? patientFile;
  final List<PBImage>? images;

  PatientFileFormState({
    this.patientFile,
    this.images,
  });
}

@riverpod
class PatientFileFormController extends _$PatientFileFormController {
  @override
  Future<PatientFileFormState> build(
      {required String parentId, String? id}) async {
    final result = await TaskResult.Do(($) async {
      final patientFile =
          await ref.read(patientFileControllerProvider(parentId).future);

      if (id == null) {
        return PatientFileFormState(
          patientFile: null,
        );
      }

      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(patientFile, domain));

      return PatientFileFormState(
        patientFile: patientFile,
        images: images,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<List<PBImage>?> _buildInitialImages(
      PatientFile? patientFile, String domain) {
    return TaskResult.tryCatch(() async {
      if (patientFile == null) {
        return null;
      }

      if (patientFile.file.isEmpty) {
        return null;
      }

      final imageUri = PBUtils.imageBuilder(
        collection: patientFile.collectionId,
        domain: domain,
        fileName: patientFile.file,
        id: patientFile.id,
      );

      if (imageUri == null) {
        return null;
      }

      return [
        PBNetworkImage(
          fileName: patientFile.file,
          uri: imageUri,
          field: PatientFileField.file,
          id: patientFile.id,
        )
      ];
    }, Failure.handle);
  }
}
