import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/users/data/user_repository.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_controller.g.dart';
part 'user_form_controller.mapper.dart';

@MappableClass()
class UserFormState with UserFormStateMappable {
  final User? user;
  final List<PBImage>? images;

  UserFormState({
    required this.user,
    this.images,
  });
}

@riverpod
class UserFormController extends _$UserFormController {
  @override
  Future<UserFormState> build(String? id) async {
    final userRepo = ref.read(userRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return UserFormState(
          user: null,
          images: null,
        );
      }

      final user = await $(userRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(user, domain));

      return UserFormState(
        user: user,
        images: images,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}

TaskResult<List<PBImage>?> _buildInitialImages(User? user, String domain) {
  return TaskResult.tryCatch(() async {
    if (user == null || user.avatar == null) {
      return null;
    }

    final imageUri = PBUtils.imageBuilder(
      collection: user.collectionId,
      domain: domain,
      fileName: user.avatar!,
      id: user.id,
    );

    if (imageUri == null) {
      return null;
    }

    return [
      PBNetworkImage(
        fileName: user.avatar!,
        uri: imageUri,
        field: UserField.avatar,
        id: user.id,
      )
    ];
  }, Failure.handle);
}
