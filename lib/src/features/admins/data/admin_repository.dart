import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/classes/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/strings/pb_expand.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'admin_repository.g.dart';

@Riverpod(keepAlive: true)
PBAuthRepository<Admin> adminRepository(Ref ref) {
  return AdminRepositoryImpl(
    pb: ref.read(pocketbaseProvider),
  );
}

class AdminRepositoryImpl implements PBAuthRepository<Admin> {
  final PocketBase pb;

  RecordService get collection => pb.collection(PocketBaseCollections.admins);

  AdminRepositoryImpl({required this.pb});

  final expand = PBExpand.admin;

  Admin mapToData(Map<String, dynamic> map) {
    return Admin.fromMap({...map, 'domain': pb.baseURL});
  }

  ///
  /// Update an admin
  ///
  @override
  TaskResult<Admin> update(
    Admin admin,
    Map<String, dynamic> params, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(
      () async {
        final updateMap = {...params};
        final body = updateMap..removeWhere((key, value) => value is XFile);

        final response = await collection.update(
          admin.id,
          body: body,
          files: files,
          expand: expand,
        );
        final map = Map<String, dynamic>.from(response.data);
        return mapToData(map);
      },
      Failure.handle,
    );
  }

  ///
  /// Create a new admin
  ///
  @override
  TaskResult<Admin> create(
    Map<String, dynamic> params, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(
      () async {
        final response = await collection.create(
          body: params,
          files: files,
          expand: expand,
        );
        return mapToData(response.toJson());
      },
      Failure.handle,
    );
  }

  ///
  /// Delete an admin
  ///
  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(
      () async {
        await collection.delete(id);
      },
      Failure.handle,
    );
  }

  ///
  /// Get an admin
  ///
  @override
  TaskResult<Admin> get(String id) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getOne(
          id,
          expand: expand,
        );
        return mapToData(result.toJson());
      },
      Failure.handle,
    );
  }

  ///
  /// List admins
  ///
  @override
  TaskResult<PageResults<Admin>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getList(
          page: pageNo,
          perPage: pageSize,
          expand: expand,
        );

        return PageResults<Admin>(
          items: result.items.map<Admin>((e) {
            return mapToData(e.toJson());
          }).toList(),
          perPage: result.perPage,
          page: result.page,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.admins);
      for (final id in ids) {
        batchCollection.update(
          id,
          body: {AdminField.isDeleted: true},
          expand: expand,
        );
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<void> confirmVerification(String token) {
    return TaskResult.tryCatch(
      () async {
        await collection.confirmVerification(token);
      },
      Failure.handle,
    );
  }

  @override
  TaskResult<void> requestVerification(String email) {
    return TaskResult.tryCatch(
      () async {
        await collection.requestVerification(email);
      },
      Failure.handle,
    );
  }
}
