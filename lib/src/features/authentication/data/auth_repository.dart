import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/flutter_secure_storage.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/user/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    storage: ref.read(flutterSecureStorageProvider),
    recordModelKey: 'AUTH_MODEL_KEY',
    tokenKey: 'AUTH_TOKEN',
    pb: ref.read(pocketbaseProvider),
  );
}

abstract class AuthRepository {
  TaskResult<User> login(Map<String, dynamic> payload);
  TaskResult<void> logout();
  TaskResult<User> refresh();
  TaskResult<User> getSavedUser();
  TaskResult<User> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage storage;
  final PocketBase pb;
  final String recordModelKey;
  final String tokenKey;

  AuthRepositoryImpl({
    required this.pb,
    required this.storage,
    required this.recordModelKey,
    required this.tokenKey,
  });

  RecordService get collection => pb.collection('users');

  AuthStore get authStore => pb.authStore;

  TaskResult<User> _saveToStorage(String token, RecordModel record) {
    return TaskResult.tryCatch(
      () async {
        final user = User.fromMap(record.toJson());

        ///
        /// store token
        ///
        await storage.write(
          key: tokenKey,
          value: token,
        );

        ///
        /// store record model
        ///
        await storage.write(
          key: recordModelKey,
          value: jsonEncode(record.toJson()),
        );

        authStore.save(token, record);

        return user;
      },
      Failure.tryCatchData,
    );
  }

  TaskResult<User> login(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final email = payload['email'];
        final password = payload['password'];

        return await collection.authWithPassword(
          email.trim(),
          password.trim(),
        );
      },
      Failure.tryCatchData,
    ).flatMap((r) => _saveToStorage(r.token, r.record));
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(() async {
      authStore.clear();
      await storage.delete(key: recordModelKey);
      await storage.delete(key: tokenKey);
    }, Failure.tryCatchData);
  }

  TaskResult<User> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
  }) {
    return TaskResult.tryCatch(
      () async {
        ///
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

        ///
        /// check if email is valid format
        ///
        final emailReg = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (!emailReg.hasMatch(email)) {
          throw Failure('Email is invalid', StackTrace.current);
        }

        ///
        /// passwords must match
        ///
        if (password != passwordConfirm) {
          throw Failure('Passwords do not match', StackTrace.current);
        }

        ///
        /// passwords must be min 8 characters
        ///
        if (password.length < 8) {
          throw Failure('Password must be min 8 chars', StackTrace.current);
        }

        final payload = {
          'email': email.trim(),
          'name': name.trim(),
          'password': password.trim(),
          'passwordConfirm': passwordConfirm,
        };

        final result = await collection.create(body: payload);

        return result;
      },
      Failure.tryCatchData,
    ).flatMap((f) => login({'email': email, 'password': password}));
  }

  TaskResult<User> refresh() {
    return TaskResult.tryCatch(
      () async {
        return await collection.authRefresh();
      },
      Failure.tryCatchData,
    ).flatMap((r) => _saveToStorage(r.token, r.record));
  }

  @override
  TaskResult<User> getSavedUser() {
    return TaskResult.tryCatch(
      () async {
        ///
        /// token
        ///
        final token = await storage.read(key: tokenKey);

        ///
        /// record model
        ///
        final modelString = await storage.read(key: recordModelKey);

        final recordModel = RecordModel.fromJson(json.decode(modelString!));

        if (token == null) throw Failure('token is null', StackTrace.current);

        authStore.save(token, recordModel);

        return User.fromMap(recordModel.toJson());
      },
      Failure.tryCatchData,
    );
  }
}
