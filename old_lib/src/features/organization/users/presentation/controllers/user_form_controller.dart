import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_file.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/features/organization/branches/data/branch_repository.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/organization/users/data/user_repository.dart';
import 'package:sannjosevet/src/features/organization/users/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_form_controller.g.dart';
part 'user_form_controller.mapper.dart';

@MappableClass()
class UserFormState with UserFormStateMappable {
  final User? user;
  final List<PBFile>? images;
  final List<Branch> branches;

  UserFormState({
    required this.user,
    this.images,
    this.branches = const [],
  });
}

@riverpod
class UserFormController extends _$UserFormController {
  @override
  Future<UserFormState> build(String? id) async {
    final userRepo = ref.read(userRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final branches = await $(_getBranches());

      if (id == null) {
        return UserFormState(
          user: null,
          images: null,
          branches: branches,
        );
      }

      final user = await $(userRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(user, domain));

      return UserFormState(
        user: user,
        images: images,
        branches: branches,
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

TaskResult<List<PBFile>?> _buildInitialImages(User? user, String domain) {
  return TaskResult.tryCatch(() async {
    if (user == null || user.avatar == null || user.avatar!.isEmpty) {
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
      PBNetworkFile(
        fileName: user.avatar!,
        uri: imageUri,
        field: UserField.avatar,
        id: user.id,
      )
    ];
  }, Failure.handle);
}
