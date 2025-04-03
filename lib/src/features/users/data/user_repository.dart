import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/users/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

abstract class UserRepository {
  TaskResult<User> get(String id);
  TaskResult<PageResults<User>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  });
  TaskResult<void> delete(String id);
  TaskResult<User> update(
    User user,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  });

  TaskResult<User> create(Map<String, dynamic> payload);
  TaskResult<void> softDeleteMulti(List<String> ids);

  TaskResult<void> requestVerification(String email);
  TaskResult<void> confirmVerification(String token);
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class UserRepositoryImpl extends UserRepository {
  final PocketBase pb;

  UserRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.users);

  @override
  TaskResult<User> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return User.fromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<User> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload);
      return User.fromMap(response.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<PageResults<User>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        page: pageNo,
        perPage: pageSize,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<User>((e) {
          return User.fromMap(e.toJson());
        }).toList(),
      );
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<User> update(
    User user,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final userMap = user.toMap();
      final combinedMap = {...userMap, ...update};
      final result = await collection.update(
        user.id,
        body: combinedMap,
        files: files,
      );
      return User.fromMap(result.toJson());
    }, Failure.tryCatchData);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(PocketBaseCollections.users);
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
