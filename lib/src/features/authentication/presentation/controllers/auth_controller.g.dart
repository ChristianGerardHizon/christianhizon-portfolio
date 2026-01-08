// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AuthData> {
  AuthControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'64c61d46df3fd688ebec800444257b3a824b8b2b';

abstract class _$AuthController extends $AsyncNotifier<AuthData> {
  FutureOr<AuthData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthData>, AuthData>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AuthData>, AuthData>,
        AsyncValue<AuthData>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
