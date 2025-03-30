import 'package:cross_file/cross_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/admins/domain/admin.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'admin_repository.g.dart';

abstract class AdminRepository {
  TaskResult<PageResults<Admin>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<Admin> get(String id);
  TaskResult<void> delete(String id);
  TaskResult<Admin> update(
    Admin admin,
    Map<String, dynamic> params, {
    List<MultipartFile> files = const [],
  });
  TaskResult<Admin> create({
    required Map<String, dynamic> params,
    List<MultipartFile> files = const [],
  });
  TaskResult<void> softDeleteMulti(List<String> ids);

  TaskResult<void> requestVerification(String email);
  TaskResult<void> confirmVerification(String token);
}

@Riverpod(keepAlive: true)
AdminRepository adminRepository(Ref ref) {
  return AdminRepositoryImpl(
    pb: ref.read(pocketbaseProvider),
  );
}

class AdminRepositoryImpl implements AdminRepository {
  final PocketBase pb;

  RecordService get collection => pb.collection(PocketBaseCollections.admins);

  AdminRepositoryImpl({required this.pb});

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
        );
        final map = Map<String, dynamic>.from(response.data);
        return Admin.fromMap(map);
      },
      Failure.tryCatchData,
    );
  }

  ///
  /// Create a new admin
  ///
  @override
  TaskResult<Admin> create({
    required Map<String, dynamic> params,
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(
      () async {
        final response = await collection.create(
          body: params,
          files: files,
        );
        return Admin.fromMap(response.toJson());
      },
      Failure.tryCatchData,
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
      Failure.tryCatchData,
    );
  }

  ///
  /// Get an admin
  ///
  @override
  TaskResult<Admin> get(String id) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getOne(id);
        return Admin.fromMap(result.toJson());
      },
      Failure.tryCatchData,
    );
  }

  ///
  /// List admins
  ///
  @override
  TaskResult<PageResults<Admin>> list({
    String? query,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getList(
          page: pageNo,
          perPage: pageSize,
        );

        return PageResults<Admin>(
          items: result.items.map<Admin>((e) {
            return Admin.fromMap(e.toJson());
          }).toList(),
          page: result.page,
          perPage: result.perPage,
          totalItems: result.totalItems,
          totalPages: result.totalPages,
        );
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.admins);
      for (final id in ids) {
        batchCollection.update(id, body: {'isDeleted': true});
      }

      await batch.send();
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> confirmVerification(String token) {
    return TaskResult.tryCatch(
      () async {
        await collection.confirmVerification(token);
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<void> requestVerification(String email) {
    return TaskResult.tryCatch(
      () async {
        await collection.requestVerification(email);
      },
      Failure.tryCatchData,
    );
  }
}
