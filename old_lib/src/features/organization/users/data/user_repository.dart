import 'package:sannjosevet/src/core/models/pb_repository.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/strings/pb_expand.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/organization/users/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
PBAuthRepository<User> userRepository(Ref ref) {
  return UserRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class UserRepositoryImpl extends PBAuthRepository<User> {
  final PocketBase pb;

  UserRepositoryImpl({required this.pb});

  RecordService get collection => pb.collection(PocketBaseCollections.users);

  User mapToData(Map<String, dynamic> map) {
    return User.fromMap({...map, 'domain': pb.baseURL});
  }

  final expand = PBExpand.user.toString();

  @override
  TaskResult<User> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<User> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response =
          await collection.create(body: payload, files: files, expand: expand);
      return mapToData(response.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<User>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        page: pageNo,
        perPage: pageSize,
        expand: expand,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<User>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
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
        expand: expand,
      );
      return mapToData(result.toJson());
    }, Failure.handle);
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
