// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminRepository)
final adminRepositoryProvider = AdminRepositoryProvider._();

final class AdminRepositoryProvider extends $FunctionalProvider<
    PBAuthRepository<Admin>,
    PBAuthRepository<Admin>,
    PBAuthRepository<Admin>> with $Provider<PBAuthRepository<Admin>> {
  AdminRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'adminRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adminRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBAuthRepository<Admin>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBAuthRepository<Admin> create(Ref ref) {
    return adminRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBAuthRepository<Admin> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PBAuthRepository<Admin>>(value),
    );
  }
}

String _$adminRepositoryHash() => r'a4b523e3f0c5cf992975e02bec70631a52e14ff2';
