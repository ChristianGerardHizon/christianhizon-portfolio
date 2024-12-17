import 'package:cross_file/cross_file.dart';
import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/common_widgets/app_root.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/endpoints.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'user_repository.g.dart';

abstract class UserRepository {
  TaskResult<PageResults<User>> list({
    String? query,
    int? pageNo,
    int? pageSize,
  });
  TaskResult<User> get(String id);
  TaskResult<void> delete(String id);
  TaskResult<User> update(User user, Map<String, dynamic> update);
  TaskResult<User> create(Map<String, dynamic> payload);
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(
    pb: ref.read(pocketbaseProvider),
  );
}

class UserRepositoryImpl implements UserRepository {
  final PocketBase pb;

  RecordService get collection => pb.collection('users');

  UserRepositoryImpl({required this.pb});
  @override
  TaskResult<User> update(User user, Map<String, dynamic> update) {
    return TaskResult.tryCatch(
      () async {
        if (update[UserField.name] == null || update[UserField.name].isEmpty) {
          throw Failure(
              'Name must be between 5 and 255 characters', StackTrace.current);
        }

        final updateMap = {...update};

        /// convert the XFiles in updateMap to a list of MultipartFile
        final futureFiles = updateMap.values.whereType<XFile>().mapWithIndex(
          (xFile, index) async {
            final key = updateMap.keys.toList()[index];
            final bytes = await xFile.readAsBytes();
            return await MultipartFile.fromBytes(key, bytes);
          },
        ).toList();

        final body = updateMap..removeWhere((key, value) => value is XFile);

        final files = await Future.wait(futureFiles);

        final response = await collection.update(
          user.id,
          body: body,
          files: files,
        );
        final map = Map<String, dynamic>.from(response.data);
        return User.fromMap(map);
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<User> create(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final response = await _dio.post(
          EndPoints.users,
          data: payload,
        );
        final map = Map<String, dynamic>.from(response.data);
        return User.fromMap(map);
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(
      () async {
        final response = await _dio.delete('${EndPoints.users}/$id');
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<User> get(String id) {
    return TaskResult.tryCatch(
      () async {
        final response = await _dio.get('${EndPoints.users}/$id');
        final map = Map<String, dynamic>.from(response.data);
        return User.fromMap(map);
      },
      Failure.tryCatchData,
    );
  }

  @override
  TaskResult<PageResults<User>> list(
      {String? query, int? pageNo, int? pageSize}) {
    return TaskResult.tryCatch(
      () async {
        final response = await _dio.get(EndPoints.users);
        final map = Map<String, dynamic>.from(response.data);
        return PageResults<User>(
          items: map['items']?.map<User>((e) {
                return User.fromMap(e);
              }).toList() ??
              [],
          page: map['page'],
          perPage: map['perPage'],
          totalItems: map['totalItems'],
          totalPages: map['totalPages'],
        );
      },
      Failure.tryCatchData,
    );
  }
}
