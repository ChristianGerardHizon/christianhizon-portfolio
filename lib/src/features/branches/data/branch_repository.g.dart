// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(branchRepository)
final branchRepositoryProvider = BranchRepositoryProvider._();

final class BranchRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<Branch>,
        PBCollectionRepository<Branch>,
        PBCollectionRepository<Branch>>
    with $Provider<PBCollectionRepository<Branch>> {
  BranchRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'branchRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$branchRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<Branch>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<Branch> create(Ref ref) {
    return branchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<Branch> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<Branch>>(value),
    );
  }
}

String _$branchRepositoryHash() => r'49afa507e6fabf4961ab4cb95cd670e86dbd226e';
