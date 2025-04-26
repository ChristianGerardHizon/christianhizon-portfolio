// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$branchTableControllerHash() =>
    r'b76f7910816ff10e8fe5097894d28b87229aa9a6';

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

abstract class _$BranchTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<Branch>> {
  late final String tableKey;

  FutureOr<List<Branch>> build(
    String tableKey,
  );
}

/// See also [BranchTableController].
@ProviderFor(BranchTableController)
const branchTableControllerProvider = BranchTableControllerFamily();

/// See also [BranchTableController].
class BranchTableControllerFamily extends Family<AsyncValue<List<Branch>>> {
  /// See also [BranchTableController].
  const BranchTableControllerFamily();

  /// See also [BranchTableController].
  BranchTableControllerProvider call(
    String tableKey,
  ) {
    return BranchTableControllerProvider(
      tableKey,
    );
  }

  @override
  BranchTableControllerProvider getProviderOverride(
    covariant BranchTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'branchTableControllerProvider';
}

/// See also [BranchTableController].
class BranchTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BranchTableController,
        List<Branch>> {
  /// See also [BranchTableController].
  BranchTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => BranchTableController()..tableKey = tableKey,
          from: branchTableControllerProvider,
          name: r'branchTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$branchTableControllerHash,
          dependencies: BranchTableControllerFamily._dependencies,
          allTransitiveDependencies:
              BranchTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  BranchTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
  }) : super.internal();

  final String tableKey;

  @override
  FutureOr<List<Branch>> runNotifierBuild(
    covariant BranchTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(BranchTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BranchTableControllerProvider._internal(
        () => create()..tableKey = tableKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BranchTableController, List<Branch>>
      createElement() {
    return _BranchTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BranchTableControllerProvider && other.tableKey == tableKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BranchTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Branch>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _BranchTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BranchTableController,
        List<Branch>> with BranchTableControllerRef {
  _BranchTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as BranchTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
