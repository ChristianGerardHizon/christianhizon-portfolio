// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the UserRolesRepository instance.

@ProviderFor(userRolesRepository)
final userRolesRepositoryProvider = UserRolesRepositoryProvider._();

/// Provides the UserRolesRepository instance.

final class UserRolesRepositoryProvider extends $FunctionalProvider<
    UserRolesRepository,
    UserRolesRepository,
    UserRolesRepository> with $Provider<UserRolesRepository> {
  /// Provides the UserRolesRepository instance.
  UserRolesRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userRolesRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userRolesRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRolesRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRolesRepository create(Ref ref) {
    return userRolesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRolesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRolesRepository>(value),
    );
  }
}

String _$userRolesRepositoryHash() =>
    r'9b4f53d686f2918e813c141d890d3777886725b6';
