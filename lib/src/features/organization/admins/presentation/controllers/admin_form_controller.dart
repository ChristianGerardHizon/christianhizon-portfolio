import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/models/pb_file.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/utils/pb_utils.dart';
import 'package:sannjosevet/src/features/organization/admins/data/admin_repository.dart';
import 'package:sannjosevet/src/features/organization/admins/domain/admin.dart';
import 'package:sannjosevet/src/features/organization/branches/domain/branch.dart';
import 'package:sannjosevet/src/features/organization/branches/presentation/controllers/branches_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_form_controller.g.dart';
part 'admin_form_controller.mapper.dart';

@MappableClass()
class AdminFormState with AdminFormStateMappable {
  final Admin? admin;
  final List<PBFile>? images;
  final List<Branch> branches;

  AdminFormState({
    required this.admin,
    this.branches = const [],
    this.images,
  });
}

@riverpod
class AdminFormController extends _$AdminFormController {
  @override
  Future<AdminFormState> build(String? id) async {
    final adminRepo = ref.read(adminRepositoryProvider);
    final branches = await ref.read(branchesControllerProvider.future);

    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return AdminFormState(admin: null, images: null, branches: branches);
      }

      final admin = await $(adminRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(admin, domain));

      return AdminFormState(
        admin: admin,
        images: images,
        branches: branches,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}

TaskResult<List<PBFile>?> _buildInitialImages(Admin? admin, String domain) {
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
      PBNetworkFile(
        fileName: admin.avatar!,
        uri: imageUri,
        field: AdminField.avatar,
        id: admin.id,
      )
    ];
  }, Failure.handle);
}
