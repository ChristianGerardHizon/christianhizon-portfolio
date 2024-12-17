import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/flutter_secure_storage.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/endpoints.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    storage: ref.read(flutterSecureStorageProvider),
    idKey: 'AUTH_ID',
    tokenKey: 'AUTH_TOKEN',
    pb: ref.read(pocketbaseProvider),
  );
}

class AuthRepository {
  final FlutterSecureStorage storage;
  final PocketBase pb;
  final String idKey;
  final String tokenKey;

  AuthRepository({
    required this.pb,
    required this.storage,
    required this.idKey,
    required this.tokenKey,
  });

  RecordService get collection => pb.collection('users');

  TaskResult<User> login(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final email = payload['email'];
        final password = payload['password'];

        final response = await dio.post(
          EndPoints.login,
          // options: Options(
          //   headers: {'ignore_auth': true},
          // ),
          data: {
            'identity': email.trim(),
            'password': password.trim(),
          },
        );

        final map = Map<String, dynamic>.from(response.data);
        await storage.write(
          key: tokenKey,
          value: map['token'],
        );
        final record = Map<String, dynamic>.from(map['record']);
        await storage.write(
          key: idKey,
          value: record['id'],
        );

        final user = User.fromMap(record);

        return user;
      },
      Failure.tryCatchData,
    );
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(() async {
      await storage.delete(key: idKey);
      await storage.delete(key: tokenKey);
    }, Failure.tryCatchData);
  }

  Map<String, dynamic> parse(String data) {
    int attempts = 0;
    var result = jsonDecode(data);
    while (attempts < 5) {
      try {
        result = Map<String, dynamic>.from(jsonDecode(result));
        if (result is Map) {
          return Map<String, dynamic>.from(result);
        }
      } catch (e) {
        // Handle the error if necessary or continue to retry
      }
      attempts++;
    }
    throw Failure(
      'Failed to parse data into a Map<String, dynamic> after 5 attempts ${result.runtimeType}',
    );
  }

  TaskResult<void> _refreshTokenAndSaveToLocal() {
    return TaskResult.tryCatch(
      () async {
        final response = await dio.post(EndPoints.refreshToken);
        final result = Map<String, dynamic>.from(response.data);
        await storage.write(
          key: tokenKey,
          value: result['token'],
        );

        final record = result['record'];
        await storage.write(
          key: idKey,
          value: record['id'],
        );
      },
      Failure.tryCatchData,
    );
  }

  TaskResult<User> _createUser({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
    required String contactNumber,
  }) {
    return TaskResult.tryCatch(
      () async {
        /// check if fields are valid
        ///
        if (email.isEmpty) {
          throw Failure('Email is missing', StackTrace.current);
        }

        if (name.isEmpty) {
          throw Failure('Name is missing', StackTrace.current);
        }

        if (password.isEmpty) {
          throw Failure('Password is missing', StackTrace.current);
        }
        if (passwordConfirm.isEmpty) {
          throw Failure('Password confirmation is missing', StackTrace.current);
        }

        if (contactNumber.isEmpty) {
          throw Failure('Contact number is missing', StackTrace.current);
        }

        /// check if email is valid format
        ///
        final emailReg = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (!emailReg.hasMatch(email)) {
          throw Failure('Email is invalid', StackTrace.current);
        }

        /// passwords must match
        ///
        if (password != passwordConfirm) {
          throw Failure('Passwords do not match', StackTrace.current);
        }

        /// passwords must be min 8 characters
        if (password.length < 8) {
          throw Failure('Password must be min 8 chars', StackTrace.current);
        }

        final response = await dio.post(
          EndPoints.users,
          data: {
            'email': email.trim(),
            'name': name.trim(),
            'password': password.trim(),
            'isStoreOwner': false,
            'passwordConfirm': passwordConfirm,
            'storeLimit': 1,
            'contactNumber': '+63$contactNumber',
          },
        );

        /// append email since its not returned by the api
        final map = Map<String, dynamic>.from({
          ...response.data,
          'email': email,
        });
        return User.fromMap(map);
      },
      Failure.tryCatchData,
    );
  }

  TaskResult<User> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
    required String contactNumber,
  }) {
    return TaskResult.Do(($) async {
      final user = await $(_createUser(
        email: email,
        name: name,
        password: password,
        passwordConfirm: passwordConfirm,
        contactNumber: contactNumber,
      ));
      return await $(login({
        'email': email,
        'password': password,
      }));
    });
  }

  TaskResult<void> refresh() {
    return _refreshTokenAndSaveToLocal();
  }

  /// Returns the stored token in the storage.
  TaskResult<String> getToken() {
    return TaskResult.tryCatch(() async {
      final token = await storage.read(key: tokenKey);
      if (token == null) {
        throw 'token is null';
      }
      return token;
    }, Failure.tryCatchData);
  }

  TaskResult<String> getId() {
    return TaskResult.tryCatch(() async {
      final id = await storage.read(key: idKey);
      if (id == null) {
        throw 'id is null';
      }
      return id;
    }, Failure.tryCatchData);
  }
}
