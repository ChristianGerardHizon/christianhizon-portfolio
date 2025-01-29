import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/flutter_secure_storage.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
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
  TaskResult<AuthUser> login(AuthUserType type, Map<String, dynamic> payload);
  TaskResult<void> logout();
  TaskResult<AuthUser> refresh();
  TaskResult<AuthUser> initialize();
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

  TaskResult<AuthUser> _saveToStorage(RecordAuth recordAuth) {
    return TaskResult.tryCatch(
      () async {
        final token = recordAuth.token;
        final record = recordAuth.record;

        final appUser = AuthUser(
          collectionId: record.collectionId,
          collectionName: record.collectionName,
          id: record.id,
          token: token,
          type: AuthUserTypeMapper.fromValue(record.collectionName),
        );

        ///
        /// store
        ///
        await storage.write(
          key: authKey,
          value: appUser.toJson(),
        );

        authStore.save(token, record);

        return appUser;
      },
      Failure.tryCatchData,
    );
  }

  TaskResult<AuthUser> login(AuthUserType type, Map<String, dynamic> payload) {
    return TaskResult.tryCatch(
      () async {
        final email = payload[UserField.email];
        final password = payload[UserField.password];

        return await pb.collection(type.name).authWithPassword(email, password);
      },
      (error, stack) {
        return Failure.tryCatchData(error, stack);
      },
    ).flatMap(_saveToStorage);
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(() async {
      authStore.clear();
      await storage.delete(key: authKey);
    }, Failure.tryCatchData);
  }

  TaskResult<AuthUser> refresh() {
    return TaskResult.tryCatch(
      () async {
        final id = authStore.record?.id;

        if (id == null) {
          throw Failure('collectionId is null', StackTrace.current);
        }

        return await pb.collection(id).authRefresh();
      },
      Failure.tryCatchData,
    ).flatMap(_saveToStorage);
  }

  @override
  TaskResult<AuthUser> initialize() {
    return TaskResult.tryCatch(
      () async {
        ///
        /// token
        ///
        final authUserString = await storage.read(key: authKey);

        if (authUserString == null) {
          throw Failure('authUserString is null', StackTrace.current);
        }

        final authUser = AuthUser.fromJson(authUserString);
        authStore.clear();
        authStore.save(authUser.token, null);

        final authModel =
            await pb.collection(authUser.collectionId).authRefresh();

        authStore.save(authModel.token, authModel.record);

        final token = authModel.token;
        final record = authModel.record;

        return AuthUser(
          id: record.id,
          type: authUser.type,
          collectionId: record.collectionId,
          collectionName: record.collectionName,
          token: token,
        );
      },
      Failure.tryCatchData,
    );
  }
}
