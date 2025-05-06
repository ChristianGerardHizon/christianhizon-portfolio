import 'package:file_picker/file_picker.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:http/http.dart';

class FilePickerUtil {
  static TaskResult<List<MultipartFile>?> getImage(String fieldName,
      {int limit = 1}) {
    return TaskResult.tryCatch(
      () async {
        final result = await FilePicker.platform.pickFiles();

        if (result == null || result.files.isEmpty) return null;

        final listResult = result.files
            .map((e) async => await MultipartFile.fromPath(fieldName, e.path!,
                filename: e.name))
            .toList();

        return Future.wait(listResult);
      },
      Failure.handle,
    );
  }
}
