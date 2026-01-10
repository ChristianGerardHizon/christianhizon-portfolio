// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRepository)
final userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider extends $FunctionalProvider<
    PBAuthRepository<User>,
    PBAuthRepository<User>,
    PBAuthRepository<User>> with $Provider<PBAuthRepository<User>> {
  UserRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBAuthRepository<User>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBAuthRepository<User> create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBAuthRepository<User> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PBAuthRepository<User>>(value),
    );
  }
}

String _$userRepositoryHash() => r'028f071bb2224430a383c3048eba55c6de254da5';
