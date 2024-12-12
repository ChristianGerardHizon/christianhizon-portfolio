import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/dio.dart';
import 'package:gym_system/src/core/strings/endpoints.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/user/domain/user.dart';

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
    dio: ref.read(dioProvider),
  );
}

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;

  UserRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  TaskResult<User> update(User user, Map<String, dynamic> update) {
    return TaskResult.tryCatch(
      () async {
        if (update[UserField.name] == null || update[UserField.name].isEmpty) {
          throw Failure(
              'Name must be between 5 and 255 characters', StackTrace.current);
        }

        final updateMap = {...update};

        ///
        /// convert XFile to MultipartFile
        ///
        final photo = updateMap[UserField.profilePhoto];
        if (photo is XFile) {
          final multipartFile = await MultipartFile.fromFile(
            photo.path,
            filename: photo.name,
          );
          updateMap[UserField.profilePhoto] = multipartFile;
        }

        final payload = FormData.fromMap(updateMap);
        final response = await _dio.patch(
          '${EndPoints.users}/${user.id}',
          data: payload,
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
