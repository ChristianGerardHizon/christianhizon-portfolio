// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changeLogRepository)
final changeLogRepositoryProvider = ChangeLogRepositoryProvider._();

final class ChangeLogRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<ChangeLog>,
        PBCollectionRepository<ChangeLog>,
        PBCollectionRepository<ChangeLog>>
    with $Provider<PBCollectionRepository<ChangeLog>> {
  ChangeLogRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'changeLogRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$changeLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<ChangeLog>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<ChangeLog> create(Ref ref) {
    return changeLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<ChangeLog> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<ChangeLog>>(value),
    );
  }
}

String _$changeLogRepositoryHash() =>
    r'1dfcb5d766882055ee2f38654b8e2f95a02f1e33';
