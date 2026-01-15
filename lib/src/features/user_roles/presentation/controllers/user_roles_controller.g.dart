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
final userRolesControllerProvider = UserRolesControllerFamily._();

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
  UserRolesControllerProvider._(
      {required UserRolesControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userRolesControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userRolesControllerHash();

  @override
  String toString() {
    return r'userRolesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserRolesController create() => UserRolesController();

  @override
  bool operator ==(Object other) {
    return other is UserRolesControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userRolesControllerHash() =>
    r'17b8be3bffa0107c416006511b83a9a92bb27239';

/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.

final class UserRolesControllerFamily extends $Family
    with
        $ClassFamilyOverride<UserRolesController, AsyncValue<UserRoleEntity?>,
            UserRoleEntity?, FutureOr<UserRoleEntity?>, String> {
  UserRolesControllerFamily._()
      : super(
          retry: null,
          name: r'userRolesControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  /// Controller for managing the current user's role.
  ///
  /// Fetches and stores the user role after login.
  /// The role is cleared on logout.

  UserRolesControllerProvider call(
    String id,
  ) =>
      UserRolesControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'userRolesControllerProvider';
}

/// Controller for managing the current user's role.
///
/// Fetches and stores the user role after login.
/// The role is cleared on logout.

abstract class _$UserRolesController extends $AsyncNotifier<UserRoleEntity?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<UserRoleEntity?> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserRoleEntity?>, UserRoleEntity?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserRoleEntity?>, UserRoleEntity?>,
        AsyncValue<UserRoleEntity?>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
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

String _$isAdminHash() => r'd5fbda49fe95a57c99a342cafdd03f5b0a87b987';
