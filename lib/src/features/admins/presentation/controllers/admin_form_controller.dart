import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/admins/data/admin_repository.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_form_controller.g.dart';
part 'admin_form_controller.mapper.dart';

@MappableClass()
class AdminFormState with AdminFormStateMappable {
  final Admin? admin;
  final List<PBImage>? images;

  AdminFormState({
    required this.admin,
    this.images,
  });
}

@riverpod
class AdminFormController extends _$AdminFormController {
  @override
  Future<AdminFormState> build(String? id) async {
    final adminRepo = ref.read(adminRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return AdminFormState(
          admin: null,
          images: null,
        );
      }

      final admin = await $(adminRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(admin, domain));

      return AdminFormState(
        admin: admin,
        images: images,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}

TaskResult<List<PBImage>?> _buildInitialImages(Admin? admin, String domain) {
  return TaskResult.tryCatch(() async {
    if (admin == null || admin.avatar == null) {
      return null;
    }

    final imageUri = PBUtils.imageBuilder(
      collection: admin.collectionId,
      domain: domain,
      fileName: admin.avatar!,
      id: admin.id,
    );

    if (imageUri == null) {
      return null;
    }

    return [
      PBNetworkImage(
        fileName: admin.avatar!,
        uri: imageUri,
        field: AdminField.avatar,
        id: admin.id,
      )
    ];
  }, Failure.handle);
}
