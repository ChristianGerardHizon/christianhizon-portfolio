// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_version_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(systemVersionRepository)
final systemVersionRepositoryProvider = SystemVersionRepositoryProvider._();

final class SystemVersionRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<SystemVersion>,
        PBCollectionRepository<SystemVersion>,
        PBCollectionRepository<SystemVersion>>
    with $Provider<PBCollectionRepository<SystemVersion>> {
  SystemVersionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'systemVersionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$systemVersionRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<SystemVersion>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<SystemVersion> create(Ref ref) {
    return systemVersionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<SystemVersion> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<SystemVersion>>(value),
    );
  }
}

String _$systemVersionRepositoryHash() =>
    r'b360261dc5def03d8baca200e4c1434a2866ea71';
