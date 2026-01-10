import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/pb_file.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/features/patient_files/domain/patient_file.dart';
import 'package:sannjosevet/src/features/patient_files/presentation/controllers/patient_file_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_file_form_controller.g.dart';

class PatientFileFormState {
  final PatientFile? patientFile;
  final List<PBFile>? images;

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
      if (id == null) {
        return PatientFileFormState(
          patientFile: null,
        );
      }

      final patientFile =
          await ref.read(patientFileControllerProvider(id).future);

      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(patientFile, domain));

      return PatientFileFormState(
        patientFile: patientFile,
        images: images,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<List<PBFile>?> _buildInitialImages(
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
        PBNetworkFile(
          fileName: patientFile.file,
          uri: imageUri,
          field: PatientFileField.file,
          id: patientFile.id,
        )
      ];
    }, Failure.handle);
  }
}
