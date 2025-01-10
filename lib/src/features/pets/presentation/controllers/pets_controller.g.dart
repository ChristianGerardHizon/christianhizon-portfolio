// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pets_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petsControllerHash() => r'622d9aa2ea12ba6377e744b14db9971bea9df247';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PetsController
    extends BuildlessAutoDisposeAsyncNotifier<List<Pet>> {
  late final int page;
  late final int pageSize;

  FutureOr<List<Pet>> build(
    int page, {
    int pageSize = 50,
  });
}

/// See also [PetsController].
@ProviderFor(PetsController)
const petsControllerProvider = PetsControllerFamily();

/// See also [PetsController].
class PetsControllerFamily extends Family<AsyncValue<List<Pet>>> {
  /// See also [PetsController].
  const PetsControllerFamily();

  /// See also [PetsController].
  PetsControllerProvider call(
    int page, {
    int pageSize = 50,
  }) {
    return PetsControllerProvider(
      page,
      pageSize: pageSize,
    );
  }

  @override
  PetsControllerProvider getProviderOverride(
    covariant PetsControllerProvider provider,
  ) {
    return call(
      provider.page,
      pageSize: provider.pageSize,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'petsControllerProvider';
}

/// See also [PetsController].
class PetsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PetsController, List<Pet>> {
  /// See also [PetsController].
  PetsControllerProvider(
    int page, {
    int pageSize = 50,
  }) : this._internal(
          () => PetsController()
            ..page = page
            ..pageSize = pageSize,
          from: petsControllerProvider,
          name: r'petsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$petsControllerHash,
          dependencies: PetsControllerFamily._dependencies,
          allTransitiveDependencies:
              PetsControllerFamily._allTransitiveDependencies,
          page: page,
          pageSize: pageSize,
        );

  PetsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.pageSize,
  }) : super.internal();

  final int page;
  final int pageSize;

  @override
  FutureOr<List<Pet>> runNotifierBuild(
    covariant PetsController notifier,
  ) {
    return notifier.build(
      page,
      pageSize: pageSize,
    );
  }

  @override
  Override overrideWith(PetsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetsControllerProvider._internal(
        () => create()
          ..page = page
          ..pageSize = pageSize,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PetsController, List<Pet>>
      createElement() {
    return _PetsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetsControllerProvider &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PetsControllerRef on AutoDisposeAsyncNotifierProviderRef<List<Pet>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _PetsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PetsController, List<Pet>>
    with PetsControllerRef {
  _PetsControllerProviderElement(super.provider);

  @override
  int get page => (origin as PetsControllerProvider).page;
  @override
  int get pageSize => (origin as PetsControllerProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
