// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.

@ProviderFor(UserRolesController)
final userRolesControllerProvider = UserRolesControllerProvider._();

/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.
final class UserRolesControllerProvider
    extends $AsyncNotifierProvider<UserRolesController, UserRoleEntity?> {
  /// Controller for managing the current user's role.
  ///
  /// Fetches and stores the user role after login.
  /// The role is cleared on logout.
  UserRolesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userRolesControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userRolesControllerHash();

  @$internal
  @override
  UserRolesController create() => UserRolesController();
}

String _$userRolesControllerHash() =>
    r'7e6bb78129cdce051599840a8d437da098e29bb3';

/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.

abstract class _$UserRolesController extends $AsyncNotifier<UserRoleEntity?> {
  FutureOr<UserRoleEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserRoleEntity?>, UserRoleEntity?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserRoleEntity?>, UserRoleEntity?>,
        AsyncValue<UserRoleEntity?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Convenience provider that returns whether the current user is an admin.

@ProviderFor(isAdmin)
final isAdminProvider = IsAdminProvider._();

/// Convenience provider that returns whether the current user is an admin.

final class IsAdminProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience provider that returns whether the current user is an admin.
  IsAdminProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isAdminProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isAdminHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAdmin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAdminHash() => r'72bc28d0c1e665b8516476a8665e4d5273574dc2';
