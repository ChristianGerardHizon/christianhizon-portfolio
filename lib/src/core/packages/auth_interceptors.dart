import 'package:dio/dio.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/authentication/data/auth_repository.dart';
import 'package:gym_system/src/features/settings/data/setting_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_interceptors.g.dart';

@Riverpod(keepAlive: true)
AuthInterceptor authInterceptor(Ref ref) {
  return AuthInterceptor(
    authRepo: ref.read(authRepositoryProvider),
    settingsRepo: ref.read(settingRepositoryProvider),
  );
}

class AuthInterceptor implements InterceptorsWrapper {
  final AuthRepository authRepo;
  final SettingRepository settingsRepo;

  AuthInterceptor({required this.authRepo, required this.settingsRepo});

  @override
  void onError(DioException exception, ErrorInterceptorHandler handler) {
    handler.next(exception);
  }

  @override
  Future<void> onRequest(
    RequestOptions baseOptions,
    RequestInterceptorHandler handler,
  ) async {
    final result = await TaskResult<RequestOptions>.Do(($) async {
      final settings = await $(settingsRepo.get());
      final domain = settings.domain;

      /// add the domain to the options
      final options = baseOptions.copyWith(
        baseUrl: domain,
      );

      ///
      /// If the request has the header ignore_auth, then ignore the authentication
      ///
      if (options.headers['ignore_auth'] == true) {
        return options;
      }

      final token =
          await $(authRepo.getToken().orElse((x) => TaskResult.right('')));

      options.headers['Authorization'] = 'Bearer $token';
      return options;
    }).run();
    return handler.next(result.fold((l) => baseOptions, (r) => r));
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
