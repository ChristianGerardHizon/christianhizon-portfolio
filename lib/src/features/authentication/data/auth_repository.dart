import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/packages/flutter_secure_storage.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';
import 'package:sannjosevet/src/core/packages/pocketbase_collections.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/strings/pb_expand.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/admins/domain/admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_admin.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_data.dart';
import 'package:sannjosevet/src/features/authentication/domain/auth_user.dart';
import 'package:sannjosevet/src/features/users/domain/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    storage: ref.read(flutterSecureStorageProvider),
    authKey: 'AUTH_KEY',
    pb: ref.read(pocketbaseProvider),
  );
}

abstract class AuthRepository {
  TaskResult<AuthAdmin> loginAsAdmin(Map<String, dynamic> payload);
  TaskResult<AuthUser> loginAsUser(Map<String, dynamic> payload);
  TaskResult<void> logout();
  TaskResult<AuthData> refresh();
  TaskResult<AuthData> initialize();
}

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage storage;
  final PocketBase pb;
  final String authKey;

  AuthRepositoryImpl({
    required this.pb,
    required this.storage,
    required this.authKey,
  });

  AuthStore get authStore => pb.authStore;

  TaskResult<T> _saveToStorage<T>(RecordAuth recordAuth) {
    return TaskResult.tryCatch(
      () async {
        final token = recordAuth.token;
        final record = recordAuth.record;

        AuthData? data;
        if (record.collectionName == PocketBaseCollections.users) {
          data = AuthUser(
            collectionName: record.collectionName,
            collectionId: record.collectionId,
            id: record.id,
            token: token,
            record: User.fromMap({...record.data, 'domain': pb.baseURL}),
          );
        }

        if (record.collectionName == PocketBaseCollections.admins) {
          data = AuthAdmin(
            collectionName: record.collectionName,
            collectionId: record.collectionId,
            id: record.id,
            token: token,
            record: Admin.fromMap({...record.data, 'domain': pb.baseURL}),
          );
        }
        if (data == null) throw 'unknown user type';

        ///
        /// store
        ///
        await storage.write(
          key: authKey,
          value: data.toJson(),
        );
        authStore.save(token, record);
        return data as T;
      },
      Failure.handle,
    );
  }

  TaskResult<AuthAdmin> loginAsAdmin(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final email = payload[UserField.email];
        final password = payload[UserField.password];

        return await pb
            .collection(
              PocketBaseCollections.admins,
            )
            .authWithPassword(
              email,
              password,
              expand: PBExpand.admin.toString(),
            );
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    ).flatMap((x) => _saveToStorage<AuthAdmin>(x));
  }

  TaskResult<AuthUser> loginAsUser(Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final email = payload[UserField.email];
        final password = payload[UserField.password];

        return await pb
            .collection(PocketBaseCollections.users)
            .authWithPassword(
              email,
              password,
              expand: PBExpand.user.toString(),
            );
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    ).flatMap((x) => _saveToStorage<AuthUser>(x));
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(
      () async {
        authStore.clear();
        await storage.delete(key: authKey);
      },
      Failure.handle,
    );
  }

  TaskResult<AuthData> refresh() {
    return TaskResult.tryCatch(
      () async {
        final collection = authStore.record?.collectionName;

        if (collection == null) {
          throw DataFailure('collection is null', StackTrace.current);
        }

        if (collection == PocketBaseCollections.admins) {
          return await pb.collection(collection).authRefresh(
                expand: PBExpand.admin.toString(),
              );
        }

        if (collection == PocketBaseCollections.users) {
          return await pb
              .collection(collection)
              .authRefresh(expand: PBExpand.user.toString());
        }

        throw DataFailure(
            'collection is unknown ($collection)', StackTrace.current);
      },
      Failure.handle,
    ).flatMap(_saveToStorage);
  }

  @override
  TaskResult<AuthData> initialize() {
    return TaskResult.tryCatch(
      () async {
        ///
        /// token
        ///
        final authUserString = await storage.read(key: authKey);

        if (authUserString == null) {
          throw NoAuthFailure('authUserString is null', StackTrace.current);
        }

        final map = jsonDecode(authUserString);
        final oldtoken = map['token'];
        final oldCollection = map['collectionName'];
        authStore.save(oldtoken, null);

        final authModel = oldCollection == PocketBaseCollections.admins
            ? await pb
                .collection(oldCollection)
                .authRefresh(expand: PBExpand.admin.toString())
            : await pb
                .collection(oldCollection)
                .authRefresh(expand: PBExpand.user.toString());

        authStore.save(authModel.token, authModel.record);

        final token = authModel.token;
        final record = authModel.record;

        if (record.collectionName == PocketBaseCollections.users) {
          return AuthUser(
            collectionName: record.collectionName,
            collectionId: record.collectionId,
            id: record.id,
            token: token,
            record: User.fromMap({...record.data, 'domain': pb.baseURL}),
          );
        }

        if (record.collectionName == PocketBaseCollections.admins) {
          return AuthAdmin(
            collectionName: record.collectionName,
            collectionId: record.collectionId,
            id: record.id,
            token: token,
            record: Admin.fromMap({...record.data, 'domain': pb.baseURL}),
          );
        }
        throw 'unknown user type';
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    );
  }
}
