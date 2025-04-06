// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$branchControllerHash() => r'94b0a81386c398a0daad360a6e93d28592a20320';

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

abstract class _$BranchController
    extends BuildlessAutoDisposeAsyncNotifier<Branch> {
  late final String id;

  FutureOr<Branch> build(
    String id,
  );
}

/// See also [BranchController].
@ProviderFor(BranchController)
const branchControllerProvider = BranchControllerFamily();

/// See also [BranchController].
class BranchControllerFamily extends Family<AsyncValue<Branch>> {
  /// See also [BranchController].
  const BranchControllerFamily();

  /// See also [BranchController].
  BranchControllerProvider call(
    String id,
  ) {
    return BranchControllerProvider(
      id,
    );
  }

  @override
  BranchControllerProvider getProviderOverride(
    covariant BranchControllerProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'branchControllerProvider';
}

/// See also [BranchController].
class BranchControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BranchController, Branch> {
  /// See also [BranchController].
  BranchControllerProvider(
    String id,
  ) : this._internal(
          () => BranchController()..id = id,
          from: branchControllerProvider,
          name: r'branchControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$branchControllerHash,
          dependencies: BranchControllerFamily._dependencies,
          allTransitiveDependencies:
              BranchControllerFamily._allTransitiveDependencies,
          id: id,
        );

  BranchControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<Branch> runNotifierBuild(
    covariant BranchController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(BranchController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BranchControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BranchController, Branch>
      createElement() {
    return _BranchControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BranchControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BranchControllerRef on AutoDisposeAsyncNotifierProviderRef<Branch> {
  /// The parameter `id` of this provider.
  String get id;
}

class _BranchControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BranchController, Branch>
    with BranchControllerRef {
  _BranchControllerProviderElement(super.provider);

  @override
  String get id => (origin as BranchControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
